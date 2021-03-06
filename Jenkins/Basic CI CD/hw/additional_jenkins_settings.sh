#!/bin/bash

echo "### Checking created jenkins user..."
cat /etc/passwd | grep jenkins

echo "### Adding sudo user 'jenkins' to the Docker group, to be able to work with docker without the need to use always sudo..."
sudo usermod -aG jenkins && usermod -aG jenkins

echo "### Change jenkin's shell from '/bin/false' to '/bin/bash'"
JENKINS_USER=$(cat /etc/passwd | grep jenkins)
[[ "$JENKINS_USER" == *bin/false ]] && sudo usermod -s /bin/bash jenkins

echo "### Adding the jenkins user to the sudoers list..."
sudo sh -c "echo \"jenkins ALL=(ALL) NOPASSWD: ALL\" >> /etc/sudoers"

#echo "### Switch to jenkins user, chnage it's password, generate a public/private key pair and copy the SSH key to the jenkins host machine..."
#sudo su - jenkins
sudo chpasswd <<<"jenkins:Password1"
echo | ssh-keygen -t rsa -m PEM -P '' -C jenkins@localhost
JENKINS_SSH_DIR="/var/lib/jenkins/.ssh"
[ -d $JENKINS_SSH_DIR ] || sudo mkdir $JENKINS_SSH_DIR && echo "Directory '$JENKINS_SSH_DIR' created."
sudo cp /root/.ssh/id_rsa /var/lib/jenkins/.ssh/ && sudo cp /root/.ssh/id_rsa.pub /var/lib/jenkins/.ssh/
sudo rm /root/.ssh/id_rsa && sudo rm /root/.ssh/id_rsa.pub
echo "### Copy the SSH key to the jenkins machine..."
sudo sshpass -p "Password1" ssh-copy-id -i /var/lib/jenkins/.ssh/id_rsa.pub jenkins@localhost || true

echo "### Disabling Jenkins security to prevent unlocking..."
sudo sed -i 's/<useSecurity>true<\/useSecurity>/<useSecurity>false<\/useSecurity>/g' /var/lib/jenkins/config.xml
sudo ex +g/useSecurity/d +g/authorizationStrategy/d -scwq /var/lib/jenkins/config.xml

echo "### Restarting jenkins service..."
sudo systemctl restart jenkins

echo "### Checking jenkins status..."
while true ; do
    sleep 5
    if [ "$(systemctl is-active jenkins)" = "active" ]; then 
        echo "Jenkins service is up! Checking jenkins status..."
        systemctl status jenkins
        break
    fi
done
