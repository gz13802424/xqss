-- Copyright 2015 Daniel Dickinson <openwrt@daniel.thecshore.com>
-- Licensed to the public under the Apache License 2.0.

local fs = require("nixio.fs")

local m = Map("uhttpd", translate("Web Admin Settings"),
	      translate("Web Admin Settings Page"))

local pass = m:section(TypedSection,"_dummy","")
pass.addremove = false
pass.anonymous = true

pw1 = pass:option(Value,"pw1",translate("Password"))
pw1.password = true
pw2 = pass:option(Value,"pw2",translate("Confirmation"), translate("Changes the administrator password for accessing the device"))
pw2.password = true

function pass.cfgsections()
    return{"_pass"}
end

function m.parse(a)
local e = pw1:formvalue("_pass")
local t = pw2:formvalue("_pass")
if e and t and#e>0 and#t>0 then
    if e==t then
        if luci.sys.user.setpasswd(luci.dispatcher.context.authuser,e)==0 then
            m.message=translate("Password successfully changed!")
        else
            m.message=translate("Unknown Error, password not changed!")
        end
    else
        m.message=translate("Given password confirmation did not match, password not changed!")
    end
end
Map.parse(a)
end

local ucs = m:section(TypedSection, "uhttpd")
ucs.addremove = false
ucs.anonymous = true
lhttp = ucs:option(DynamicList, "listen_http", translate("HTTP listeners (address:port)"), translate("Bind to specific interface:port (by specifying interface address"))
lhttp.datatype = "list(ipaddrport(1))"

function lhttp.validate(self, value, section)
        local have_https_listener = false
        local have_http_listener = false
	if lhttp and lhttp:formvalue(section) and (#(lhttp:formvalue(section)) > 0) then
		for k, v in pairs(lhttp:formvalue(section)) do
			if v and (v ~= "") then
				have_http_listener = true
				break
			end
		end
	end
	if lhttps and lhttps:formvalue(section) and (#(lhttps:formvalue(section)) > 0) then
		for k, v in pairs(lhttps:formvalue(section)) do
			if v and (v ~= "") then
				have_https_listener = true
				break
			end
		end
	end
	if not (have_http_listener or have_https_listener) then
		return nil, "must listen on at list one address:port"
	end
	return DynamicList.validate(self, value, section)
end

o = ucs:option(Flag, "redirect_https", translate("Redirect all HTTP to HTTPS"))
o.default = o.enabled
o.rmempty = false
o.description = translate("Redirect all HTTP to HTTPS when SSl cert was installed")

o = ucs:option(Flag, "rfc1918_filter", translate("Ignore private IPs on public interface"), translate("Prevent access from private (RFC1918) IPs on an interface if it has an public IP address"))
o.default = o.enabled
o.rmempty = false

return m
