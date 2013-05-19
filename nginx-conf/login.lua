-- login.lua
-- Login Module in Lua

-- TODO Introduce CSFR token in login form and redirection to basic page, detect json request

-- This is only a POST Endpoint
if ngx.req.get_method() == "POST" then
	
	-- Read request body
	ngx.req.read_body()
    local args = ngx.req.get_post_args()
    -- Sanity Check for username and password
    if string.match(args["username"],"%W") or string.match(args["password"],"%W") then
    	-- Improper charactors detected
    	ngx.exit(ngx.HTTP_BAD_REQUEST)
    else
    	-- Fire the sql to check for 
    	local resp = ngx.location.capture("/sso/login?username="..args['username'].."&hash="..args['password'])
    	_, _, no, uid, data = string.find(resp.body, [[%[%{"no":(%d+),"uid":(%d+),"data":"([%w ]+)"%}%]%s*]])
    	if tonumber(no) == 1 then
    		-- valid user, Generate a session_token
    		resp = ngx.location.capture("/sso/token")
    		_, _, token = string.find(resp.body, [[%[%{"token":"(%w+)"%}%]%s*]])

    		-- Delete all stale session information for this uid
    		resp = ngx.location.capture("/sso/session/stale?uid="..uid)
    		_, _, errcode, affected_rows = string.find(resp.body, [[%{"errcode":(%d+),"affected_rows":(%d+)%}%s*]])
    		
    		-- Save token in session
    		resp = ngx.location.capture("/sso/session/add?token="..token.."&uid="..uid)
    		_, _, errcode, affected_rows = string.find(resp.body, [[%{"errcode":(%d+),"affected_rows":(%d+)%}%s*]])
    		
    		if tonumber(errcode) == 0 and tonumber(affected_rows) == 1 then
    			-- Token set in database, set cookiee
    			local expires = tonumber(ngx.time()) + 3600
    			ngx.header["Set-Cookie"] = "uid="..uid..";path=/;domain=.maanas.co;expires="..ngx.cookie_time(expires)
    			ngx.header["Set-Cookie"] = "session_token="..token..";path=/;domain=.maanas.co;expires="..ngx.cookie_time(expires)
    			-- Redirect to Incoming Page
                if (ngx.var.cookie_MNPLRedirectBack ~= nil) then
	    		    return ngx.redirect(ngx.var.cookie_AGMSRedirectBack)
                else 
                    return ngx.redirect("http://sso.maanas.co/sso/welcome.html")
                end
    		else 
    			ngx.exit(ngx.HTTP_BAD_REQUEST)		
    		end
     	else 
    		ngx.exit(ngx.HTTP_UNAUTHORIZED)	
    	end
    end
else 
	ngx.exit(ngx.HTTP_BAD_REQUEST)
end 