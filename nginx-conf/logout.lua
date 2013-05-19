-- login.lua
-- Login Module in Lua

-- TODO Introduce CSFR token in login form and redirection to basic page, detect json request
-- Check the session token exist
if ngx.var.cookie_session_token then
    -- Sanity Check for session_token
    if string.match(ngx.var.cookie_session_token,"%W") then
        -- We got a poisioned cookie
        ngx.exit(ngx.HTTP_BAD_REQUEST)
    else 
        -- Destroy token in session
        ngx.location.capture("/sso/session/delete?token="..ngx.var.cookie_session_token)
        -- Delete all cookie
        ngx.header["Set-Cookie"] = "uid=deleted;path=/;domain=.maanas.co;expires=Thu, 01-Jan-1970 00:00:01 GMT"
        ngx.header["Set-Cookie"] = "session_token=deleted;path=/;domain=.maanas.co;expires=Thu, 01-Jan-1970 00:00:01 GMT"
        -- Save the logout URl so that we can come back to this page
        ngx.header["Set-Cookie"] = "AGMSRedirectBack=http://"..ngx.var.host..ngx.var.uri..";path=/;domain=.maanas.co;Max-Age=120"
        -- Redirect to login form
        return ngx.redirect("http://sso.maanas.co/sso") 
    end
else        
    return ngx.redirect("http://sso.maanas.co/sso") 
    
end
