-------------------------------------------------------------------------------
-- @module Control

-------------------------------------------------------------------------------
-- Parent class for all GUI components
-- Perform common tasks for all controls on screen 
-- @type Control
-- @field #number _bg brightness of background
-- @field #number _fg brightness of foreground
-- @field #boolean _visible status of control visibility
local Control = class()

-------------------------------------------------------------------------------
-- Initialization method
-- Intialize private fields with default or given in #attrs values
-- @function [parent = #Control] init
-- @param self
-- @param #table attrs fieldname(without underscore) = value. May be ommited.
function Control:init(attrs, logger)
  assert(logger, 'Parameter \'logger\' not specified!')
  self._funcId = 0x00
  self._parent = {}
  self._id = ''
  self._type = ''
  self._name = ''
  self._visible = false or attrs.visible
  self._enable = false or attrs.enable
  self._focused = false or attrs.focused
  self._foreground = 15 or attrs.foreground
  self._background = 0 or attrs.background
  self._left = 0 or attrs.left
  self._top = 0 or attrs.top
  self._width = 0 or attrs.width
  self._height = 0 or attrs.height
  self._halign = 'center' or attrs.halign
  self._valign = 'center' or attrs.valign
  self._buffer = ''
  self._logger = logger
end

function Control:getAttrName(s)
  return string.match(s, '%%(%w+)%%')
end

function Control:setProperty(name, value)
  if name == nil or name == '' then
    self._logger:print(2, 'no name specified.')
    return
  end
  if value == nil then
    self._logger:print(2, 'no value specified.')
    return
  end
  if self['_'..name] == nil then
    self._logger:print(2, 'property \'_'..name..'\' does not exist')
    return
  end
  self['_'..name] = value
  self._logger:print(3, '_'..name..' is set to '..value)
end

function Control:getProperty(name)
  if name == nil or name == '' then
    self._logger:print(2, 'no name specified.')
    return nil
  end
  return self['_'..name]
end
-------------------------------------------------------------------------------
-- Return status of visibility of control on screen
-- @function [parent = #Control] isVisible
-- @param self
function Control:isVisible()
  return self._visible
end

-------------------------------------------------------------------------------
-- Set status of visibility of control on screen
-- @function [parent = #Control] setVisible
-- @param self
-- @param #boolean value status to set  
function Control:setVisible(value)
  if value == nil then
    self._logger:print(2, 'value not specified.')
    return
  end
  self:setProperty('visible', value)
end

function Control:getEnable()
  return self._enable
end

function Control:setEnable(value)
  if value == nil then
    self._logger:print(2, 'value not specified.')
    return
  end
  self:setProperty('enable', value)
end

function Control:isFocused()
  return self._focused
end

function Control:setFocused(value)
  if value == nil then
    self._logger:print(2, 'value not specified.')
    return
  end
  self:setProperty('focused', value)
end

function Control:setForeground(value)
  if value == nil then
    self._logger:print(2, 'brightness not specified.')
    return
  end
  self:setProperty('foreground', value)
  self:draw()
end

function Control:getForeground()
  return self._foreground
end

function Control:setBackground(value)
  if brightness == nil then
    self._logger:print(2, 'brightness not specified.')
    return
  end
  self:setProperty('background', value)
  self:draw()
end

function Control:getBackground()
  return self._background
end

function Control:setParent(value)
  if parent == nil then
    self._logger:print(2, 'parent not specified.')
    return
  end
  self:setProperty('parent', value)
end

function Control:setWidth(value)
  if value == nil then
    self._logger:print(2, 'width not specified.')
    return
  end
  self:setProperty('width', value)
  self:draw()
end

function Control:getWidth()
  return self._width
end

function Control:setHeight(value)
  if value == nil then
    self._logger:print(2, 'height not specified.')
    return
  end
  self:setProperty('height', value)
  self:draw()
end

function Control:getHeight()
  return self._height
end


function Control:setSize(width, height)
  if width == nil or height == nil then
      self._logger:print(2, 'width or height not specified.')
    return
  end
  self:setProperty('width', width)
  self:setProperty('height', height)
    self:draw()
end

function Control:getSize()
    return self._width, self._height
end

function Control:setPos(left, top)
  if left == nil or top == nil then
    self._logger:print(2, 'left or top not specified.')
    return
  end
  self:setProperty('left', left)
  self:setProperty('top', top)
  self:draw()
end

function Control:getPos()
  return self._left, self._top
end

function Control:setAlign(valign, halign)
  if valign == nil and halign == nil then
    self._logger:print(2, 'valign and halign not specified.')
    return
  end
  self:setProperty('valign', valign)
  self:setProperty('halign', halign)
  self:draw()
end

function Control:getAlign()
  return self._halign, self._valign
end

return Control