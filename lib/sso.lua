-- Copyright (C) 2015 Maanas Royy (m4manas)

-- sso module

-- session duration without update
local duration = 7200

local cjson = require "cjson"

local _M = {}
local mt = { __index = _M }

local db = require "db"


-- Utlity Methods
function _M.new()
end

function _M.get_hash(self)
    local dbc, err = db.new()
    local res, err, errno, sqlstate = dbc:query("SELECT SHA2(UUID(), 256) AS hash")
    return res[1]['hash']
end

function _M.session_add(self, token, uid, persistent)
    local dbc, err = db.new()
    sql = "INSERT INTO session(s_token, s_uid, s_persistent, s_dateadded, s_lastaccess) VALUES"
    sql = sql .. "(" ..  ngx.quote_sql_str(token) .. ", " .. ngx.quote_sql_str(uid) .. ", " .. ngx.quote_sql_str(persistent) .. ", UNIX_TIMESTAMP(), UNIX_TIMESTAMP())"
    local res, err, errno, sqlstate = dbc:query(sql)
    return res.insert_id
end

function _M.session_delete(self, token)
    local dbc, err = db.new()
    sql = "DELETE FROM session WHERE s_token = " .. ngx.quote_sql_str(token)
    local res, err, errno, sqlstate = dbc:query(sql)
    return res.affected_rows
end

function _M.session_stale(self, uid)
    local dbc, err = db.new()
    sql = "DELETE FROM session WHERE s_lastaccess < (UNIX_TIMESTAMP() - " .. duration .. ") AND s_uid = " .. ngx.quote_sql_str(uid)
    local res, err, errno, sqlstate = dbc:query(sql)
    return res.affected_rows
end

function _M.token_add(self, token, uid, app)
    local dbc, err = db.new()
    sql = "REPLACE INTO token(t_token, t_uid, t_app, t_dateadded, t_lastaccess) VALUES"
    sql = sql .. "(" ..  ngx.quote_sql_str(token) .. ", " .. ngx.quote_sql_str(uid) .. ", " .. ngx.quote_sql_str(app) .. ", UNIX_TIMESTAMP(), UNIX_TIMESTAMP())"
    local res, err, errno, sqlstate = dbc:query(sql)
    return res.insert_id
end

function _M.token_delete(self, token)
    local dbc, err = db.new()
    sql = "DELETE FROM token WHERE t_token = " .. ngx.quote_sql_str(token)
    local res, err, errno, sqlstate = dbc:query(sql)
    return res.affected_rows
end

function _M.token_stale(self, uid)
    local dbc, err = db.new()
    sql = "DELETE FROM token WHERE t_lastaccess < (UNIX_TIMESTAMP() - " .. duration .. ") AND s_uid = " .. ngx.quote_sql_str(uid)
    local res, err, errno, sqlstate = dbc:query(sql)
    return res.affected_rows
end

function _M.set_password(self, email, password)
    local dbc, err = db.new()
    sql = "UPDATE user SET u_hash = SHA2(SHA1(" .. ngx.quote_sql_str(password) .. "), 256), u_lastmodified = UNIX_TIMESTAMP() WHERE u_email = " .. ngx.quote_sql_str(email)
    local res, err, errno, sqlstate = dbc:query(sql)
    return res.affected_rows
end

function _M.get_user(self, token)
    local dbc, err = db.new()
    sql = "SELECT u_id as uid, u_email as email, u_username as username, u_firstname as firstname, u_lastname as lastname, s_token as token, s_data as data   FROM user, session WHERE  s_uid = u_id  AND s_token = " .. ngx.quote_sql_str(token) .. " LIMIT 1"
    local res, err, errno, sqlstate = dbc:query(sql)
    return cjson.encode(res)
end

function _M.get_session(self, app, token)
    local dbc, err = db.new()
    sql = "SELECT 1 AS no, IFNULL(s_uid, 0) AS uid, IFNULL(s_data,'') as data  FROM session, app, app_user WHERE  s_uid = au_uid AND au_apid = ap_id AND ap_app = " .. ngx.quote_sql_str(app) .. " AND ap_enabled = 1 AND s_token = " .. ngx.quote_sql_str(token) .. "AND UNIX_TIMESTAMP() - " .. duration .. " < s_lastaccess LIMIT 1"
    local res, err, errno, sqlstate = dbc:query(sql)
    return cjson.encode(res)
end

function _M.update_session(self, token)
    local dbc, err = db.new()
    sql = "UUPDATE session SET s_lastaccess = UNIX_TIMESTAMP() WHERE s_token = " .. ngx.quote_sql_str(token)
    local res, err, errno, sqlstate = dbc:query(sql)
    return res.affected_rows
end

function _M.check_session(self, username, hash)
    local dbc, err = db.new()
    sql = "SELECT 1 as no, u_id as uid, CONCAT(u_firstname, ' ', u_lastname) as data FROM user WHERE u_username = " .. ngx.quote_sql_str(username) .. " AND u_hash = SHA2(" .. ngx.quote_sql_str(hash) .. ", 256) AND u_enabled = 1"
    local res, err, errno, sqlstate = dbc:query(sql)
    return res
end


function _M.check_token(self, app, token)
    local dbc, err = db.new()
    sql = "SELECT 1 AS no, IFNULL(t_uid, 0) AS uid, IFNULL(t_data,'') AS data  FROM token, app, app_user WHERE t_uid = au_uid AND au_apid = ap_id AND ap_enabled = 1 AND ap_app = " .. ngx.quote_sql_str(app) .. "  AND t_token = " .. ngx.quote_sql_str(token) .. " AND UNIX_TIMESTAMP() - " .. duration .. " < t_lastaccess "
    local res, err, errno, sqlstate = dbc:query(sql)
    return cjson.encode(res)
end


function _M.password(self, email, password, repassword)

end


return _M