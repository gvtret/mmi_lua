---Builder - create and manage tree of controls
local slaxml = require('slaxml.slaxml')
local Stack = require('cpmlib.Stack')
local Builder = class()

function Builder:init(xml_templates)
  self._parser = slaxml:parser{
    startElement = function(name, nsURI, nsPrefix)
      self:startElement(name, nsURI, nsPrefix)
    end,
    attribute = function(name, value, nsURI, nsPrefix)
      self:attribute(name, value, nsURI, nsPrefix)
    end,
    closeElement = function(name, nsURI)
      self:closeElement(name, nsURI)
    end
    }
    self._templates = {}
    self._xml_templates = xml_templates
    self._stack = Stack()
    self._attrs = {}
    self._current = {}
end

function Builder:startElement(name, nsURI, nsPrefix)
  self._stack:push(name)
  if name == 'Template' then
    table.insert(self._templates, {})
    self._current = self._templates[#self._templates]
    return
  end
  if cpmlib[name] == nil then
    print('Can\'t find object:', name)
    return
  end
  table.insert(self._current, cpmlib[name]({}, cpmlib.Log()))
  self._current = self._current[#self._current]
end

function Builder:attribute(name, value, nsURI, nsPrefix)
  if tonumber(value) == nil then
    self._current:setProperty(name, value)
  else
    self._current:setProperty(name, tonumber(value))
  end
end

function Builder:closeElement(name, nsURI)
  if self._stack:pop() ~= name then
    print('Error in object: ', name)
    return
  end
end

function Builder:build()
  self._parser:parse(self._xml_templates)
  return self._templates;
end

return Builder
