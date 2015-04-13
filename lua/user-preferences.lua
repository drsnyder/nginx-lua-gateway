local up = require "user-preferences";
local prefs = up.get(ngx, ngx.var.userid)
ngx.header["Content-Type"] = prefs.header["Content-Type"]
-- traverse headers?
ngx.log(ngx.NOTICE, "**** content-type: " .. prefs.header["Content-Type"])
ngx.say(prefs.body)
