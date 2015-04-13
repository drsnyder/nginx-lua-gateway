-- packages/auth.lua
module("auth", package.seeall)

local cjson = require "cjson"
local net = require "net"


-- 
function authenticate(token, helios_url)
	-- this probably won't work because we don't have a non TLS end point
	local res, err = net.request(helios_url, "POST", {}, string.format("code=%s", token))
	ngx.log(ngx.INFO, string.format("%s: status = %d and body = %s", helios_url, res.status, res.body))
	if res and res.status == 200 then
		user = deserialize(res.body)
		if user and user.user_id then
			return user.user_id
		end
	else
		ngx.log(ngx.INFO, string.format("authentication failed with token %s", token))
	end

	return nil
end

function authenticated_get(url, token, headers, helios_url)
	if not headers then
		headers = {}
	end
		
	headers["X-Wikia-UserId"] = authenticate(token, helios_url)

	return net.get(url, headers)
end

function deserialize(response)
	return cjson.new().decode(response)
end
