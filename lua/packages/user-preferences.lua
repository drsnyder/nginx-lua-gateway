local user_preferences = {}
local cjson = require "cjson"

function user_preference.get(ngx, userid)
	return ngx.location.capture("/internal-preferences/" .. userid)
end

return user_preference
