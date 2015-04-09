local cjson = require "cjson"
local response = { userid = 5 }
ngx.say(cjson.new().encode(response))
