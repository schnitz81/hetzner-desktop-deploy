#!/bin/bash

KEY_FILE="private.key"

# check if terraform is installed
if [ -z "$(which terraform)" ] ; then
        echo "terraform not found."
        exit
fi

# check if ansible is installed
if [ -z "$(which ansible-playbook)" ] ; then
        echo "ansible-playbook not found."
        exit
fi

# check if whois is installed
if [ -z "$(which mkpasswd)" ] ; then
	echo "mkpasswd not found. Please install whois package."
	exit
fi

# check if private ssh key file exists
if [ ! -f "$KEY_FILE" ]; then
	echo "$KEY_FILE not found. Place the file containing the private ssh key in a file named $KEY_FILE in the project folder."
	exit
fi

echo ; read -s -p "Set root password for VM: " rootpw
pwhash=$(mkpasswd -m sha512crypt --stdin <<< "$(echo $rootpw)")

echo ; read -s -p "Set vnc server connect password:" vncpw

terraform init &&
terraform apply -auto-approve
sleep 30
ansible-playbook --private-key "$KEY_FILE" -i inventory -e "rootpw=$pwhash" -e "vncpw=$vncpw" main.yml
