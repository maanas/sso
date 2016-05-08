#!/usr/bin/env bash

# Vagrant Ngnix, php-fpm Development Box provision

cat << EOF | sudo tee -a /etc/motd.tail
***************************************

Welcome to SSO Vagrant Ngnix Development Box provision

***************************************
EOF

### Fix for mac issue on UTF-8
sudo apt-get install language-pack-UTF-8
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
dpkg-reconfigure locales

### Common Package Install
echo "Updating Repo"
sudo apt-get update
echo "Installing Essential Packages curl vim zip unzip python pip"
sudo apt-get install -y python-software-properties curl vim zip unzip python-pip git > /dev/null

### Install build tools
echo "Installing build tools"
sudo apt-get -y install build-essential make perl > /dev/null

### Install project dependencies
echo "Installing project dependencies"
sudo apt-get -y install libreadline-dev libncurses5-dev libpcre3-dev libssl-dev > /dev/null

### Install Mysql
echo "mysql-server mysql-server/root_password password mysql" | sudo debconf-set-selections > /dev/null
echo "mysql-server mysql-server/root_password_again password mysql" | sudo  debconf-set-selections > /dev/null
sudo apt-get -y install mysql-server > /dev/null

### Change permission to execute all .sh
sudo chmod +x /vagrant/provision/*.sh

### Install luajit
sudo /vagrant/provision/lua.sh

### Install ngnix and modules
sudo /vagrant/provision/nginx.sh

### echo success message
echo "You've been provisioned"
