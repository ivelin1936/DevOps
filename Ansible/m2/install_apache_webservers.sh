#!/bin/bash

echo "### Installing Apache HTTP on webservers hosts..."
ansible webservers -i inventory -m dnf -a "name=httpd state=present" --become

echo "### Enable and start the service..."
ansible webservers -i inventory -m service -a "name=httpd state=started enabled=true" --become

echo "### Open the appropriate firewall port on the web host...."
ansible webservers -i inventory -m firewalld -a "service=http state=enabled permanent=yes immediate=yes" --become
