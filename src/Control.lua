Control = {}
Control.new = function(props)
  --private members  
  local self = {}
  local _className = 'Control'
  local _visible = true
  local _enable = true
  local _focused = false
  
  --public members
  if props ~= nil then
    for k, v in pairs(props) do
      self[k] = v
    end
  end

  self.getClassName = function()
    return _className
  end    

  self.getAttrName = function(s)
    return string.match(s, '%%(%w+)%%')
  end

  self.getVisible = function()
    return _visible
  end

  self.setVisible = function(value)
    if value ~= nil then _visible = value end
  end

  self.getEnable = function()
    return _enable
  end

  self.setEnable = function(value)
    if value ~= nil then _enable = value end
  end

  self.isFocused = function()
    return _focused
  end

  self.setFocused = function(value)
    if value ~= nil then _focused = value end
  end

  return self
end