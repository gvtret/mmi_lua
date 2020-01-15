-- MenuItem class
local Text = require("cpmlib.Text")
local MenuItem = class(Text)

function MenuItem:init(attrs, logger)
  Text.init(self, attrs, logger)
  self._selected = false
  self._caption = ''
end
  
function MenuItem:isSelected()
  return self._selected
end

function MenuItem:setSelected(value)
  if value then
    self:setText('>'..self._caption)
  else
    self:setText(' '..self._caption)
  end
  self._selected = value
end

function MenuItem:setCaption(caption)
  if caption == nil then return end
  self._caption = caption
  self:setSelected(self:isSelected())
end
return MenuItem

--[[
MenuItem = {}
MenuItem.new = function(props)
  --start
  local self = Control.new(props)

  --private members
  local _className = 'MenuItem'
  local _selected = false
  local _maxLen = 63
  
  --public members
  self.isSelected = function ()
    return _selected
  end

  self.setSelected = function (value)
    if value == nil then return end
    _selected = value
  end
  
  self.make = function(templ, object)
    for _k, _v in pairs(templ._attr) do
      local _attrName = self.getAttrName(_v)
      if _attrName == nil then
        self[_k] = _v
      else
        self[_k] = object[_attrName]
      end
    end
  
    for _k, _v in pairs(object) do
      if self[_k] == nil then
        self[_k] = _v
      end
    end
  end  
  
  self.drawText = function ()
    local _s = ' '
    if _selected == true then
      _s = '>'
    else
      _s = ' '
    end
    if self.align == 'left' then
      _s = _s..self.name..string.rep(' ',_maxLen - #self.name)
    elseif self.align == 'center' then
      _s = _s..string.rep(' ', (_maxLen - #self.name) / 2)..self.name..string.rep(' ',(_maxLen - #self.name) / 2)
    elseif self.align == 'right' then
      _s = _s..string.rep(' ', _maxLen - #self.name)..self.name
    end
    return _s..string.rep(' ',_maxLen - #_s)
  end

  self.setMaxLength = function (length)
    if length == nil then return end 
    _maxLen = length
  end
  
  self.draw = function (buff)
    buff:clear()
    buff:printat(1, 1, self.drawText())
  end
  -- end
  return self
end
--]]
