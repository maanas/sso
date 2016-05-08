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

### Install build tools
echo "Installing build toos"
sudo apt-get install build-essential make perl
### Install project dependencies
echo "Installing project dependencies"
sudo apt-get install libreadline-dev libncurses5-dev libpcre3-dev libssl-dev  

### Install ngnix and modules

### echo success message
echo "You've been provisioned"
