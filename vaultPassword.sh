#!/bin/bash

varname=$1
if [[ -z $varname ]]; then
	read -p "Password variable name: " varname
fi

passone="1"
passtwo="2"

while [[ $passone != $passtwo ]] ; do
	read -sp "Input user password: " passone
	echo
	read -sp "Input user password again: " passtwo
	[[ $passone == $passtwo ]] || echo -e "\nPasswords do not match."
done

echo
salt=$(head -c600 /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 20 | head -1)

passstring=$(ansible all -i localhost, -m debug -a "msg={{ '$passone' | password_hash('sha512','$salt') }}" | grep msg | awk -F':' '{print $2}' | cut -c2- | sed 's/"//g')
ansible-vault encrypt_string --name $varname $passstring
