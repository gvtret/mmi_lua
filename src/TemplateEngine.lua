require('List')
local xml2lua = require('xml2lua.xml2lua')
local tree = require('xml2lua.xmlhandler.tree')

TemplateEngine = {}
TemplateEngine.new = function(filename)
  --start
  local self = {}
  if filename == nil or filename == '' then
    error("Must provide name of file with templates description")
    return nil
  end
  --private members
  local _className = 'TemplateEngine'
  local _xml = xml2lua.loadFile(filename)
  local _xml_tree = tree
  --self.getScanCode = getScanCode
  xml2lua.parser(_xml_tree):parse(_xml)
  local _templates = _xml_tree.root.Templates

  local _find_templ = function(name)
    for k, v in pairs(_templates) do
      if k == name then return v end
    end
    return nil
  end

  local _find_object = function(name, objects)
    if name == '' or objects == nil then
      error('Name and objects storage must be specified')
      return nil
    end
  
    for i = 1, #objects do
      if objects[i].name == name then
        return objects[i]
      end
    end
  
    return nil
  end

  --public members
  self.build = function(templ_name, object_name)
    if templ_name == '' then
      error('Must to provide template name')
      return nil
    end
  
    if object_name == '' then
      error('Must to provide object name')
      return nil
    end
  
    local templ = _find_templ(templ_name)
    if (templ == nil) then
      error('Template not found')
      return nil
    end
  
    --if templ_name == 'Menu' then
      local object = _find_object(object_name,menus)
      if object == nil then
        error('Object with specified name was not found')
        return nil
      end
  
      local menu = List.new()
      menu.make(templ, object)
      return menu
    --end
  end

  --end
  return self
end


