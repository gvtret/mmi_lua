-- Text class
local Control = require("Control")

Text = {}
Text.new = function (props, init_value)
  --start
  local self = Control.new(props)

  --private members
  local _className = 'Text'
  local _align = 'left'
  local _value = init_value
  local _maxSize = 64

  --public members
  self.drawText = function()
    local s = ''
    local space_len = _maxSize - #_value
    if _align == 'left' then
      s = _value..string.rep(' ', space_len)
    elseif _align == 'center' then
      s =  string.rep(' ', space_len / 2).._value..string.rep(' ', space_len / 2)
    elseif _align == 'right' then
      s = string.rep(' ', space_len).._value
    end
  
    return s..string.rep(' ', _maxSize - #s)
  end  

  self.draw = function(buff)
    buff:clear(color.GREEN, color.BLACK)
    buff:printat(1, 1, self.drawText())
  end

  self.getSize = function()
    return _maxSize
  end

  self.setMaxSize = function(max_size)
    if max_size == nil then return end
    _maxSize = max_size
  end

  self.setAlign = function(align)
    if align == nil or align == '' then return end
    _align = align
  end

  self.setValue = function(value)
    if value == nil or value == '' then return end
    _value = value
  end
  --end
  return self
end

