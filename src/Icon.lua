local Control = require('Control')

Icon = {}
Icon.new = function(props, icon_type)
  --private members
  local self = Control.new(props)
  local _className = 'Icon'
  local _types = {
    def = '[ICON]',
    logo = '[TEL]',
    menu = '[MENU]',
    sub = '[SUBM]',
    table = '[TABL]',
    set = '[SET]',
    cmd = '[CMD]'
  }
  local _type = icon_type
  if _type == nil then _type = 'def' end

  local _size = #_types[_type]
  
  --public members
  self.setType = function(type)
    if _types[type] ~= nil then
      _type = type
      _size = #_types[_type]
    end
  end 
  
  self.getType = function(type)
    return _type
  end 
  
  self.getSize = function()
    return _size
  end

  self.draw = function(buff)
    buff:clear(color.GREEN, color.BLACK)
    buff:printat(1, 1, self.drawText())
  end

  self.drawText = function()
    return _types[_type]
  end
  return self
end