### M8: Exam Preparation (Practice)

##### Fo the exam prep, All hosts should be in a dedicated network - 192.168.150.0/24, but i will work on 192.168.56.0/24, because that is allowable on my machine :)

1. Pull the repository
2. Deploy virtual machines `vagrant up`

3. Enter into 'pipelines' machine via ssh `vagrant ssh pipelines`
    - open with brawser vagrant's UI on `http://192.168.56.201:8080/`
    - Install suggested plugins
    - Create first admin user
    - On the machine, login with jenkins user `su - jenkins` pass: `Password1`
        - create key `ssh-keygen -t rsa -m PEM` (do not entering nothing)
        - copy the key to the jenkins host `ssh-copy-id jenkins@pipelines.do1.exam`
        - copy the key to the docker host `ssh-copy-id jenkins@containers.do1.exam`
    - Preparation Jenkins UI
        - Add Credentials Username with password
        - Add Credentials SSH Username with private key (credentials from file), Enter directly
            - paste the contents of the private key file, into `Enter directly`, which can be extracted (on the jenkins machine) with `sudo cat /var/lib/jenkins/.ssh/id_rsa`
        - Add credentials for docker GitHub
            - Username: `<DOCKER_HUB_USERNAME>`
            - Password: `<DOCKER_HUB_TOKEN>`
            - ID: `docker-hub`
            - Description: `docker-hub`
        - Install plugins
            - SSH
            - gitea
            - Blue Ocean (not needed)
        - Configurate hosts
            - Hosts /Manage Jenkins => Configure System/ (SSH remote hosts / SSH sites)
                - hostname: `pipelines.do1.exam`
                - port: `22`
                - credentials: jenkins (Credentials from file) or jenkins (Local user with password)
            - Slave Host /Manage Jenkins => Manage Nodes and Clouds => New Node/
                - node name: `docker-node`
                - Permanent Agent -> Create
                - Set number of executors to `4`
                - Remote root dir: `/home/jenkins`
                - Enter `docker-node` in Labels
                - Usage: `Only build jobs with label expression matching this node`
                - Launch method: `Launch slave agents via SSH`
                - host: `containers.do1.exam`
                - credentials: `jenkins (Credentials from file)`
                - Host Key Verification Strategy: `Known hosts file`
        - Jenkins CLI (NO NEEDED fot this for this exam case...)
            - Configure Global Security
                - set SSH Server to Fixed port `2222`
                - Test it from the jenkins machine: `curl -Lv http://192.168.56.201:8080/login 2>&1 | grep -i 'x-ssh-endpoint'`
            - Manage Users (admin)
                - Create public/private key for the vagrant user from jenkins machine `ssh-keygen`
                - Configurate admin user - set SSH Public Keys with the return value of `cat ~/.ssh/id_rsa.pub`
            - Test CLI from the jenkins machine terminal
                - `ssh -l admin -p 2222 localhost help`
                - `ssh -l admin -p 2222 localhost version`
                - `ssh -l admin -p 2222 localhost who-am-i`

4. Enter into 'containers' machine via ssh `vagrant ssh containers`
    - Open gitea UI into the browser on `http://192.168.56.202:3000/`
    - Change the base URL to `http://192.168.56.202:3000/` and install gitea
    - Create user `--name douser --password Password1`
    - Into the docker machine execute `./clone_gitea_repo.sh` /If you are follow the steps, still repo,username and password empty, just click 3xEnter, otherwise insert your credentials/
    - Go back to the Gitea UI and open created repository
        - Make repository Visibility public (unmark 'Make repository Private' from repository settings)
        - Add repository webhook: Target URL `http://192.168.56.201:8080/gitea-webhook/post` and test it `Test delivery` /If you are follow the steps, the result should be 'successful'/

5. Go back to Jenkins UI `http://192.168.56.201:8080/` and Create new pipline into Jenkins
    - mark 'GitHub project'
        - add project url to the gitea repository
    - mark 'GitHub hook trigger for GITScm polling'
    - mark 'Poll SCM'
    - Place the Jenkins file's content into the pipline script... (Jenkinsfile is present into 'shared_piplines/')
    - Save and Build (For test)

6. Trigger pipeline via webhook
    - Go to gitea on `http://192.168.56.202:3000/douser/exam/src/branch/master/client/code/app.dat`
    - Open the file for edit - click `Edit File`
    - Change content from '2022.04.03.10:15:05' to current date time as example '2022.04.03 11:19:00'
    - Commit Changes
    - Check Jenkins `http://192.168.56.201:8080/job/exam/` to see its triggered :)

6. Enter into 'promgraf' machine via ssh `vagrant ssh promgraf` (Nothing to do into the virtual machine)
    - Open Prometheus Ui into the browser on `http://192.168.56.203:9090`
    - Open Grafana Ui into the browser on `http://192.168.56.203:3000/login`
        - default login `admin/admin`
        - Add Prometheus as datasource - /Settings -> Data Source/, ` http://192.168.56.203:9090`
        - Add panes to dashboard
            - CPU `node_cpu_seconds_total{mode="system",job=~"ne-vm201|ne-vm202|ne-vm203"}`
            - MEM `node_memory_MemAvailable_bytes{job=~"ne-vm201|ne-vm202|ne-vm203"}`
            - Containers memory usage `sum(container_memory_usage_bytes{job="cadvisor"})`
            - Docker Containers inodes total `sum(container_fs_inodes_total{job="cadvisor",  id=~'/docke.*'})`
            - Disk `node_disk_read_bytes_total{device="sda",job=~"ne-vm201|ne-vm202|ne-vm203"}`
    - Open Alertmanager Ui into the browser on `http://192.168.56.203:9093/#/status`
    - Node Exported on `http://192.168.56.203:9100/metrics`
    - Open cAdvisor (docker metrics) Ui into the browser on `http://192.168.56.203:9323/containers/`
