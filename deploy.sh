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
else
	chmod 0600 "$KEY_FILE"
	if [ $? -ne 0 ]; then
		echo "unable to set permissions on $KEY_FILE. Please check file owner."
		exit
	fi
fi

echo ; read -p "Choose server name: " servername 

echo ; read -s -p "Set root password for VM: " rootpw
pwhash=$(mkpasswd -m sha512crypt --stdin <<< "$(echo $rootpw)")

echo ; read -s -p "Set vnc server connect password: " vncpw

# allow ssh password authorization
echo ; read -p "Allow ssh password auth? (not recommended): " sshpassauth
if [ "$sshpassauth" == "y" ] || [ "$sshpassauth" == "Y" ] || [ "$sshpassauth" == "yes" ] || [ "$sshpassauth" == "YES" ]; then
	sshpassauthvar="yes"
else
	sshpassauthvar="no"
fi

terraform init &&
terraform apply -var="servername=$servername" -auto-approve
sleep 30
ansible-playbook --private-key "$KEY_FILE" -i inventory -e "rootpw=$pwhash" -e "vncpw=$vncpw" -e "sshpwauth=$sshpassauthvar" main.yml

# print out ipv4 address
grep 'ipv4_address' terraform.tfstate | tail -n 1
