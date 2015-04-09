-- handler that takes session data and returns the userid
local cjson = require "cjson"
local res = ngx.location.capture("/auth")
if res.status == 200 then
	local value = cjson.new().decode(res.body)
	if value.userid == tonumber(ngx.var.userid) then
		return
	else
		ngx.exit(ngx.HTTP_FORBIDDEN)
	end
else
	ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
end
