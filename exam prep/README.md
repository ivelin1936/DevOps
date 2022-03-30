### M8: Exam Preparation (Practice)

1. Pull the repository
2. Deploy virtual machines `vagrant up`

3. Enter into 'jenkins' machine via ssh `vagrant ssh jenkins`
    - open with brawser vagrant's UI on `http://192.168.56.11:8080/`
    - Install suggested plugins
    - Create first admin user
    - On the machine, login with jenkins user `su - jenkins` pass: `Password1`
        - create key `ssh-keygen -t rsa -m PEM` (do not entering nothing)
        - copy the key to the jenkins host `ssh-copy-id jenkins@vm11.do1.exam`
        - copy the key to the docker host `ssh-copy-id jenkins@vm12.do1.exam`
    - Preparation Jenkins UI
        - Add Credentials Username with password
        - Add Credentials SSH Username with private key (credentials from file), Enter directly
            - paste the contents of the private key file, into `Enter directly`, which can be extracted (on the jenkins machine) with `sudo cat /var/lib/jenkins/.ssh/id_rsa`
        - Add credentials for docker GitHub
            - Username: `<DOCKER_HUB_USERNAME>`
            - Password: `<DOCKER_HUB_TOKEN>` /`01f1b47d-1a4c-45cb-b8dd-07fca22950ae`/
            - ID: `docker-hub`
            - Description: `docker-hub`
        - Install plugins
            - SSH
            - gitea
            - Blue Ocean (not needed)
        - Configurate hosts
            - Hosts /Manage Jenkins => Configure System/ (SSH remote hosts / SSH sites)
                - hostname: `vm11.do1.exam`
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
                - host: `vm12.do1.exam`
                - credentials: `jenkins (Credentials from file)`
                - Host Key Verification Strategy: `Known hosts file`
        - Jenkins CLI (no needed fot this for this exam case...)
            - Configure Global Security
                - set SSH Server to Fixed port `2222`
                - Test it from the jenkins machine: `curl -Lv http://192.168.56.11:8080/login 2>&1 | grep -i 'x-ssh-endpoint'`
            - Manage Users (admin)
                - Create public/private key for the vagrant user from jenkins machine `ssh-keygen`
                - Configurate admin user - set SSH Public Keys with the return value of `cat ~/.ssh/id_rsa.pub`
            - Test CLI from the jenkins machine terminal
                - `ssh -l admin -p 2222 localhost help`
                - `ssh -l admin -p 2222 localhost version`
                - `ssh -l admin -p 2222 localhost who-am-i`

4. Enter into 'docker' machine via ssh `vagrant ssh docker`
    - Open gitea UI into the browser on `http://192.168.56.12:3000/`
    - Change the base URL to `http://192.168.56.12:3000/` and install gitea
    - Create user `--name douser --password Password1`
    - Into the docker machine execute `./clone_gitea_repo.sh` /If you are follow the steps, still repo,username and password empty, just click 3xEnter, otherwise insert your credentials/
    - Go back to the Gitea UI and open created repository
        - Make repository Visibility public (unmark 'Make repository Private' from repository settings)
        - Add repository webhook: Target URL `http://192.168.56.11:8080/gitea-webhook/post` and test it `Test delivery` /If you are follow the steps, the result should be 'successful'/

5. Enter into 'promgraf' machine via ssh `vagrant ssh promgraf`
    - Open Prometheus Ui into the browser on `http://192.168.56.13:9090`
    - Open Grafana Ui into the browser on `http://192.168.56.13:3000/login`
        - default login `admin/admin`
    - Open Alertmanager Ui into the browser on `http://192.168.56.13:9093/#/status`
    - Open cAdvisor (docker metrics) Ui into the browser on `http://192.168.56.13:9323/containers/`
