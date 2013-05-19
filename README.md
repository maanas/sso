sso
===

SSO - Single Sign On

Single Sign On is LUA based Application layer which act as authentication layer. The module create a session and store the same in mysql database. The module can also act as Web Application Firewall checking any thing we want. 

At present this works with ngnix by using following modules:

* ngx_devel_kit
* set-misc-nginx-module
* echo-nginx-module
* lua-nginx-module 
* drizzle-nginx-module
* rds-json-nginx-module 

You can build a high performance stack of nginx using the following modules. To know how to build a high performace stack. Please follow instructions here. 
http://maanasroyy.wordpress.com/2012/10/01/building-high-performance-web-server-nginx-luajit-phpfm-on-centos/

Alternatively you can use the openresty stack. Though it might be an over kill.
http://openresty.org/
