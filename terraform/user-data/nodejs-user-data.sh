#!/bin/sh
##### Install Ansible ######
apt update -y
apt install software-properties-common -y
apt-add-repository --yes --update ppa:ansible/ansible
apt install ansible -y
apt install git -y

##### Clone to ansible repository ######
git clone https://github.com/pavanmudduluru/homelike-assginment.git
cd homelike-assginment/ansible/nodejs/

##### Run your ansible playbook for only autoscaled and not initialised instances ######
ansible-playbook nodejs-setup.yaml