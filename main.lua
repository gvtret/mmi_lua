require "CiderDebugger";
TESTS = true

package.path = package.path..';./?.lua;./?/init.lua'
package.cpath = package.cpath..';./clibs/?.so;./?.so'

cpmlib = require('cpmlib') -- load framework
if TESTS then 
    require('tests') 
    return
end
local Application = require ('Application')
local EventProvider = require ('EventProvider')
local TemplateEngine = require ('TemplateEngine')
local slaxml = require('slaxml.slaxml')
require ('MmiData')

local a, b = 1, 2
a, b = b, a
local eventmap_name = 'Events.xml'
local templates_name = 'templates/MenuScreen.xml'
local templates = io.open(templates_name):read('*all')
local application = {}
local builder = cpmlib.Builder(templates)
local templ_t = builder:build()
local parser = slaxml:parser{
  startElement = function(name,nsURI,nsPrefix)
    print('Start Element:', name, nsURI, nsPrefix)
  end, -- When "<foo" or <x:foo is seen
  attribute    = function(name,value,nsURI,nsPrefix) print('Attribute:', name, nsURI, nsPrefix, value) end, -- attribute found on current element
  closeElement = function(name,nsURI) print('Close Element:', name, nsURI) end, -- When "</foo>" or </x:foo> or "/>" is seen
  }
parser:parse(templates)

local templateEngine = TemplateEngine.new(templates_name)
local eventProvider = EventProvider.new(eventmap_name)
local app = Application.new(eventProvider, templateEngine, connection)
app.init()
local ok, err = pcall(app.loop())
app.stop()

if not ok then
    print("Error: "..err)
end
