#!/bin/bash

echo "### Installing MariaDB on db hosts..."
ansible dbservers -i inventory -m dnf -a "name=mariadb,mariadb-server state=present" --become

echo "### Enable and start the service..."
ansible dbservers -i inventory -m service -a "name=mariadb state=started enabled=true" --become
