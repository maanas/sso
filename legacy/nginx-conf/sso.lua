-- Single Sign On Module in Lua
-- Check we got a request again a resource

-- Check we got session_token
if (ngx.var.cookie_session_token == nil or ngx.var.cookie_session_token == "") then
	-- Track the endpoint for redirection later
	ngx.header["Set-Cookie"] = "MNPLRedirectBack=http://"..ngx.var.host..ngx.var.uri..";path=/;domain=.maanas.co;Max-Age=120"
	return ngx.redirect("http://sso.maanas.co/sso")
else
	-- Sanity Check for session_token
	if string.match(ngx.var.cookie_session_token,"%W") then
		-- We got a poisioned cookie
		ngx.exit(ngx.HTTP_BAD_REQUEST)
	else 
		if (ngx.var.app == nil or ngx.var.app == "") then
			-- We do not got an app match against the authrization
			ngx.exit(ngx.HTTP_NOT_FOUND)
		end	
		-- Sanity Check for app is not needed as it is internal request
		local resp = ngx.location.capture("/sso/session?app="..ngx.var.app)
		if resp.status == 200 then
			_, _, no, uid, data = string.find(resp.body, [[%[%{"no":(%d+),"uid":(%d+),"data":"(%w*)"%}%]%s*]])
			if tonumber(no) == 1 then
				-- Found valid permission Update lastaccess time stamp and return
				-- Update token timestamp in session
	    		ngx.location.capture("/sso/session/update?token="..ngx.var.cookie_session_token)
				return
			else
				ngx.header["Set-Cookie"] = "MNPLRedirectBack=http://"..ngx.var.host..ngx.var.uri..";path=/;domain=.maanas.co;Max-Age=120"
				return ngx.redirect("/401")
			end
		end
	end
end