#!/usr/bin/env bash

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
