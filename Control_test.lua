package.path = './?.lua;./?/init.lua'
package.cpath = './clibs/?.so'

local cpmlib = require('cpmlib')
--[[local socket = require('socket')
local server = socket.tcp()
local s, e = server:bind('*', 9090)
assert(s, e)
local i, p   = server:getsockname()
assert(i, p)
print(os.clock().." Waiting connection from on " .. i .. ":" .. p .. "...")
s, e = server:listen(1)
assert(s, e)
local client, e = server:accept() 
assert(client, e)
local l, e = client:send('ping\n')
print(os.clock()..' Send ping')
assert(l, e)
while e == nil do
  local r, w, e = socket.select({client}, {client}, 0)
  if w[1] ~= nil then
    local l, e = w[1]:send('ping\n')
    print(os.clock()..' Send ping')
    assert(l, e)
  end
  if r[1] ~= nil then
    local data, e = r[1]:receive()
    if e == nil then
      print(os.clock()..' Get '..data)
    end
  end
end
client:close()]]

local attrs = {
  focused = true,
  visible = true,
  enable = true,
}

local Line = cpmlib.Line(attrs)
print(string.tohex(Line._buffer))
local Icon = cpmlib.Icon(attrs)
print(string.tohex(Icon._buffer))
