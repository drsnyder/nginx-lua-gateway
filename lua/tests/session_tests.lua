require "lunit"
local session = require "session"

module("session_testcase", lunit.testcase)

local header = {["Cookie"] = "wikicitiesUserName=a_user_name; wikicities_session=99deee3115870e3863a16322de052d4a; wikicitiesUserID=123456; wikicitiesToken=25b1104897f5630955fdb0b2706da3b1"}

function test_get_token()
	assert_equal("99deee3115870e3863a16322de052d4a", session.get_token(header))
end

function test_get_cookie()
	local header = {["Cookie"] = "a-cookie=a-cookie-value"}
	assert_equal("a-cookie-value", session.get_cookie(header, "a-cookie"))
end

function test_get_cookies()
	local header = {["Cookie"] = "a-cookie=a-cookie-value"}
	local cookies = session.get_cookies(header)
	assert_equal("a-cookie-value", cookies["a-cookie"])
end
