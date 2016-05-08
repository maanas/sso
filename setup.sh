#!/usr/bin/env bash

# Vagrant Ngnix, php-fpm Development Box provision

cat << EOF | sudo tee -a /etc/motd.tail
***************************************

Welcome to SSO Vagrant Ngnix Development Box provision

***************************************
EOF

### Fix for mac issue on UTF-8
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

### Install ngnix
sudo apt-get install -y nginx
sudo cp /vagrant/provision/templates/nginx.conf /etc/nginx/nginx.conf
sudo cp /vagrant/provision/templates/default /etc/nginx/sites-available/default
sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
sudo service nginx restart

### echo success message
echo "You've been provisioned"
