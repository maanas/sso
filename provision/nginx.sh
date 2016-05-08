#!/usr/bin/env bash

### Install luajit
## Clone lua
sudo git clone  https://github.com/LuaJIT/LuaJIT /opt/sso/luajit

## Make luajit
cd /opt/sso/luajit/
sudo make 
sudo make install

## Symlink lua
sudo ln -s /usr/local/lib/libluajit-5.1.so.2.0.4 /usr/local/lib/liblua.so


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

## Make directories
sudo mkdir /etc/nginx
sudo chown vagrant:vagrant /etc/nginx
sudo mkdir /var/log/nginx
sudo chown vagrant:vagrant /var/log/nginx

## Build nginx
cd /opt/sso/nginx-1.9.15
./configure \
--user=vagrant                        \
--group=vagrant                       \
--sbin-path=/usr/sbin/nginx           \
--conf-path=/etc/nginx/nginx.conf     \
--pid-path=/var/run/nginx.pid         \
--lock-path=/var/run/nginx.lock       \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--with-http_gzip_static_module        \
--with-http_stub_status_module        \
--with-http_ssl_module                \
--with-pcre                           \
--with-file-aio                       \
--with-http_realip_module             \
--add-module=/opt/sso/ngx_devel_kit   \
--add-module=/opt/sso/lua-nginx-module \
--add-module=/opt/sso/echo-nginx-module \
--add-module=/opt/sso/rds-json-nginx-module 
	

make -j2
sudo make install

## Change owenrship permissions
sudo chown vagrant:vagrant /var/log/nginx
sudo chown vagrant:vagrant /usr/local/nginx

## Make synlinks
sudo ln -s /vagrant/conf /etc/nginx/conf
