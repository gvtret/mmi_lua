require "CiderDebugger";

package.path = './?.lua;./?/init.lua'
package.cpath = './clibs/?.so;./?.so'

local cpmlib = require('cpmlib') -- load framework
local Application = require ('Application')
local EventProvider = require ('EventProvider')
local TemplateEngine = require ('TemplateEngine')
require ('MmiData')

local attrs = {
  focused = true,
  visible = true,
  enable = true,
}

local Line = cpmlib.Line(attrs)
print(string.tohex(Line._buffer))
local Icon = cpmlib.Icon(attrs)
Icon:setType('TEL')
print(string.tohex(Icon._buffer))
local hBox = cpmlib.HBox({})
hBox:addControl(Icon)
hBox:addControl(Line)

local eventmap_name = 'Events.xml'
local templates_name = 'Templates.xml'
local templateEngine = TemplateEngine.new(templates_name)
local eventProvider = EventProvider.new(eventmap_name)
local app = Application.new(eventProvider, templateEngine, connection)
app.init()
local ok, err = pcall(app.loop())
app.stop()

if not ok then
    print("Error: "..err)
end
