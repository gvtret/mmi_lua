package.path = package.path..';./src/?.lua'..';./src/xml2lua/?.lua'..';./src/u-test/?.lua'..';./src/utf8/?.lua'
require('debugger')()

require ('Application')
require ('EventProvider')
require ('TemplateEngine')
require ('MmiData')

local eventmap_name = 'src/Events.xml'
local templates_name = 'src/Templates.xml'
local templateEngine = TemplateEngine.new(templates_name)
local eventProvider = EventProvider.new(eventmap_name)
app = Application.new(eventProvider, templateEngine)
app.init()
local ok, err = pcall(app.loop())
app.stop()

if not ok then
  print("Error: "..err)
end
