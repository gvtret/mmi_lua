Control = {}
Control.new = function(props)
  --private members  
  local self = {}
  local _className = 'Control'
  
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
  return self
end