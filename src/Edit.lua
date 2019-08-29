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
  self.onBeginEdit = function(sender)
    if _edited then return end
    _edited = true
    if _masked then 
      _showValue = '>' 
      _value = ''
    end    
  end

  self.onEndEdit = function(sender)
    _edited = false
    if _masked then
      _showValue = ''
    end
  end

  self.drawText = function()
    return _showValue
  end

  self.draw = function(buff)
  end

  self.onDigit = function(sender, digit)
    if not _edited then return end
    if digit == nil or digit == '' then return end
    _value = _value..digit
    
    if _masked then
      _showValue = _showValue.._maskChar
    else
      _showValue = _showValue..digit
    end
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
  
  self.onCancelEdit = function()
    _edited = false
    _value = ''
    _showValue = ''
  end

  -- end
  return self
end
