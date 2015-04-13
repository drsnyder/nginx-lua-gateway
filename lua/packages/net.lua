-- packages/net.lua

module("net", package.seeall)

--local rocks = require "luarocks.loader"
local http = require "resty.http"

function request(url, request_method, request_headers, body)
	if not request_headers then
		request_headers = ngx.req.get_headers(20)
		request_headers["host"] = nil
	end

	local httpc = http.new()
	local res, err = httpc:request_uri(url,
	{
		method = request_method,
		headers = request_headers,
		body = body
	})

	return res, err
end

function get(url, headers)

	return request(url, "GET", headers)
end

function handle(reqfn)
	res, err = reqfn()
	if not res then
		-- TODO: http problem
		ngx.say("failed to request: ", err)
		return
	end

	ngx.header["Content-Type"] = res.headers["Content-Type"]
	ngx.say(res.body)
end
