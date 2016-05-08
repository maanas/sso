-- Test lua file
local sso = require "sso"
local hash = sso:get_hash()

res = sso:session_add(hash, 1, 0)
ngx.say(res)