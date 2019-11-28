package.path = package.path..';./src/?.lua'..';./src/xml2lua/?.lua'..';./src/u-test/?.lua'..';./src/utf8/?.lua'
require('mobdebug').start()
if DEBUG then
    require('debugger')()
end

local Application = require ('Application')
require ('EventProvider')
require ('TemplateEngine')
require ('MmiData')

local socket = require('socket')
local connection
local connected = false
while true do
    print("Try connect to 127.0.0.1:9090...")
    local c, err = socket.connect('127.0.0.1', 9090)
    if err ~= nil then
        print(err)
        print("Wait for 5 secs...")
        socket.sleep(5)
    else
        print("Connected to: "..c:getpeername())
        connection = c
        break
    end
end

local eventmap_name = 'src/Events.xml'
local templates_name = 'src/Templates.xml'
local templateEngine = TemplateEngine.new(templates_name)
local eventProvider = EventProvider.new(eventmap_name)
local app = Application.new(eventProvider, templateEngine, connection)
app.init()
local ok, err = pcall(app.loop())
app.stop()

if not ok then
    print("Error: "..err)
end
