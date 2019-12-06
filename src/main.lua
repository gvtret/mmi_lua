package.path = './src/?.lua'..';./src/xml2lua/?.lua'..';./src/u-test/?.lua'..';./src/utf8/?.lua'
package.cpath = './?.so'
if DEBUG then
    require('debugger')()
end

local Application = require ('Application')
local EventProvider = require ('EventProvider')
local TemplateEngine = require ('TemplateEngine')
local Line = require('Line')

local line = Line(nil)
require ('MmiData')


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
