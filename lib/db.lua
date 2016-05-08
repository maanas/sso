-- Copyright (C) 2015 Maanas Royy (m4manas)

-- db module (LORM)

local _M = {}
local mt = { __index = _M }

local mysql = require "resty.mysql"

function _M.new()
    -- Pull up variable from nginx
    local db, error = mysql.new()
    local ok, err, errno, sqlstate = db:connect{
        host = ngx.var.db_host,
        port = 3306,
        database = ngx.var.db_name,
        user = ngx.var.db_user,
        password = ngx.var.db_pass,
        max_packet_size = 1024 * 1024
    }
    return setmetatable({db = db, err = err}, mt)
end

function _M.query(self, sql)
    local db = self.db
    local res, err, errno, sqlstate = db:query(sql)
    return res
end


function _M.keepalive(self)
    self.db:set_keppalive()
end

return _M