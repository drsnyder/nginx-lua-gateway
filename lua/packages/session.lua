-- packages/net.lua

module("session", package.seeall)

function split(str, sep)
	local sep, fields = sep or " ", {}
	local pattern = string.format("([^%s]+)", sep)
	str:gsub(pattern, function(c) fields[#fields+1] = c end)
	return fields
end

function get_token(header)
	return get_cookie(header, "wikicities_session")
end

function get_cookie(header, name)
	return get_cookies(header)[name]
end

function get_cookies(header)
	local cookie = header["Cookie"]
	local cookies = {}
	if cookie then
		local cookie_pairs = split(cookie, "; ")
		for index, pair in ipairs(cookie_pairs) do
			local fields = split(pair, "=")
			cookies[fields[1]] = fields[2]
		end
	end

	return cookies
end
