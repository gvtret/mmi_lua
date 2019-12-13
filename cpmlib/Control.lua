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
function Control:init(attrs)
  self._funcId = 0x00
  self._parent = nil
  self._visible = false or attrs.visible
  self._enable = false or attrs.enable
  self._focused = false or attrs.focused
  self._fg = 15 or attrs.fg
  self._bg = 0 or attrs.bg
  self._l = 0 or attrs.l
  self._t = 0 or attrs.t
  self._h = 0 or attrs.h
  self._w = 0 or attrs.w
  self._buffer = ''
end

function Control:getAttrName(s)
  return string.match(s, '%%(%w+)%%')
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
  if value == nil then return end
  self._visible = value
end

function Control:getEnable()
  return self._enable
end

function Control:setEnable(value)
  if value == nil then return end
  self._enable = value
end

function Control:isFocused()
  return self._focused
end

function Control:setFocused(value)
  if value == nil then return end
  self._focused = value
end

function Control:setForeground(brightness)
  if brightness == nil then return end
  self._fg = brightness
  self:draw()
end

function Control:getForeground()
  return self._fg
end

function Control:setBackground(brightness)
  if brightness == nil then return end
  self._bg = brightness
  self:draw()
end

function Control:getBackground()
  return self._bg
end

function Control:setParent(parent)
    if parent == nil then return end
    self._parent = parent
end

function Control:setHeight(height)
  if height == nil then return end
  self._h = height
  self:draw()
end

function Control:getHeight()
  return self._h
end

function Control:setWidth(width)
  if width == nil then return end
  self._h = width
  self:draw()
end

function Control:getWidth()
  return self._w
end

function Control:setSize(width, height)
  if width == nil or height == nil then return end
  self._w = width
  self._h = height
    self:draw()
end

function Control:getSize()
    return self._w, self._h
end

function Control:setPos(l, t)
  if l == nil or t == nil then return end
  self._l = l
  self._t = t
  self:draw()
end

function Control:getPos()
  return self._l, self._t
end

return Control