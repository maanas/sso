-- Test lua file
local sso = require "sso"
local res = sso:get_hash()

ngx.say(res)