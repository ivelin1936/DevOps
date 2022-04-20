## Homework M2: Ansible

#### Assignment

You must execute the following set of tasks:

1. With the help of **Ansible** and **Vagrant** create **Docker** host and run a **nginx** container in it
You can use a role downloaded from **Ansible Galaxy**, or create the playbook all by yourself

2. With the help of **Ansible** and **Vagrant** create a two-host setup:
    - One of the hosts should be based on **Debian/Ubuntu** and the other one – on **CentOS**
    - Both hosts should see each other in terms of network communication. Their names should be **web** and **db**
    - One of the hosts should play the role of **WEB server** with web solution of your choice and **PHP** installed and the other one – **DB server** with **MySQL/MariaDB** installed
    - On the **WEB host** deploy the content of the **web** folder in **M2-Homework-Challenge-Ansible (files).zip** archive and on the other – the content of the **db** folder from the same archive

**Please note that the two tasks are two separate environments!**
Even though we should try to automate repetitive tasks as much as possible, the emphasis here is to have a working solution and not a fully automated one. Functionality over automation

### Solution

1. Create the virtual machines with `vagrant up`
2. Open SSH connection to the Ansible machine `vagrant ssh ans`
3. Generate public/private key `ssh-keygen` (still everything empty..)
4. Copy the key to other machines (web and db)
    - ssh-copy-id 192.168.56.11 (pass: vagrant)
    - ssh-copy-id 192.168.56.12 (pass: vagrant)
    - Test if host are reachable `sudo ansible all -a "hostname" -f 1` or `sudo ansible all -i inventory -m ping`
5. Navigate to `cd ans/`
6. Check if the `playbook.yml` is correct `ansible-playbook playbook.yml --syntax-check`
7. Check which hosts will be affected `ansible-playbook playbook.yml --list-hosts`
8. Execute the playbook `sudo ansible-playbook playbook.yml`
