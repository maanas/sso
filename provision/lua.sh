#!/usr/bin/env bash

## Clone lua
sudo git clone  https://github.com/LuaJIT/LuaJIT /opt/sso/luajit

## Make luajit
cd /opt/sso/luajit/
sudo make 
sudo make install

## Symlink lua
sudo ln -s /usr/local/lib/libluajit-5.1.so.2.0.4 /usr/local/lib/liblua.so