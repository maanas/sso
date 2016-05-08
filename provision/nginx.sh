#!/usr/bin/env bash

## Clone nginx from git
sudo tar -zxvf /vagrant/provision/source/nginx-1.9.15.tar.gz -C /opt/sso/

## Clone  nginx-development-kit
sudo git clone https://github.com/simpl/ngx_devel_kit.git /opt/sso/ngx_devel_kit

## Clone lua-nginx module
sudo git clone https://github.com/openresty/lua-nginx-module.git /opt/sso/lua-nginx-module

## Clone rds-json-nginx module
sudo git clone https://github.com/openresty/rds-json-nginx-module.git /opt/sso/rds-json-nginx-module

## Clone lua-cjson module
sudo git clone https://github.com/openresty/lua-cjson.git /opt/sso/lua-cjson

## Clone echo-nginx module
sudo git clone https://github.com/openresty/echo-nginx-module.git /opt/sso/echo-nginx-module

## Clone lua-resty-mysql module
sudo git clone https://github.com/openresty/lua-resty-mysql.git /opt/sso/lua-resty-mysql

## Clone lua-resty-redis module
sudo git clone https://github.com/openresty/lua-resty-redis.git /opt/sso/lua-resty-redis

## Export env variables
export LUA_LIB=/usr/local/lib/
export LUA_INC=/usr/local/include/luajit-2.0/

## Chown /opt/sso
sudo chown -R vagrant:vagrant /opt/sso

## Build nginx
/vagrant/provision/build.sh

## Make directories
sudo mkdir /etc/nginx
sudo chown vagrant:vagrant /etc/nginx
sudo mkdir /var/log/nginx
sudo chown vagrant:vagrant /var/log/nginx
