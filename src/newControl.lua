local Control = extends(nil)

function Control:_init(attr)
    self._className = 'Control'
    self._visible = true
    self._enable = true
    self._focused = false
    if attr == nil then return end
    for k, v in pairs(attr) do
      self['_'..k] = value
    end
end

function Control:getClassName()
    return self._className
end

function Control:getAttrName(s)
    return string.match(s, '%%(%w+)%%')
end

function Control:isVisible()
    return self._visible
end

function Control:setVisible(value)
    if value ~= nil then self._visible = value end
end

function Control:getEnable()
    return self._enable
end

function Control:setEnable(value)
    if value ~= nil then self._enable = value end
end

function Control:isFocused()
    return self._focused
end

function Control:setFocused(value)
    if value ~= nil then self._focused = value end
end

return Control