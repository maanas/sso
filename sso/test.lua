-- Test lua file
local sso = require "sso"
res = sso:get_hash()
ngx.say(res)