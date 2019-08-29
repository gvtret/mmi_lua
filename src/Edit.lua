--- @module Edit
-- Edit class.
-- Class for editable fields with masked support
require('Control')
Edit = {}
Edit.new = function(props, haveMask, size)
  -- start
  local self = Control.new(props)

  -- private members
  local _value = ''
  local _showValue = ''
  local _maskChar = '*'
  local _masked = false
  if haveMask ~= nil then _masked = haveMask end
  local _edited = false
  local _valueType = ''
  local _currentIndex = 1
  local _size = 1
  if _size ~= nil then _size = size end

  -- public members
  self.onEnter = function(sender)
    if not self.getEnable() then return end
    _edited = not _edited
    if _masked then
      if _edited then 
        _showValue = '>' 
        _value = ''
      else
        _showValue = ''
      end
    end    
    
    return true
  end

  self.drawText = function()
    return _showValue
  end

  self.draw = function(buff)
    if _edited then
      buff:clear(color.BLACK, color.GREEN)
    else
      buff:clear(color.GREEN, color.BLACK)
    end
    buff:printat(1, 1, self.drawText())
  end

  self.onDigit = function(sender, attr)
    if not self.getEnable() then return end
    if not _edited then return end
    local digit = attr.name
    if digit == nil or digit == '' then return end
    _value = _value..digit
    
    if _masked then
      _showValue = _showValue.._maskChar
    else
      _showValue = _showValue..digit
    end
    return true
  end
  
  self.isEdited = function()
    return _edited
  end

  self.isMasked = function()
    return _masked
  end

  self.getValue = function()
    return _value
  end
  
  self.setSize = function(value)
    if value ~= nil then _size = value end
  end
  
  self.getSize = function(value)
    return _size
  end
  
  self.onCancelEdit = function(sender, attr)
    if not self.getEnable() then return end
    _edited = false
    _value = ''
    _showValue = ''
    return true
  end

  self.onCancelRepeat = function(sender, attr)
    if not self.getEnable() then return end
    return true
  end

  -- end
  return self
end
