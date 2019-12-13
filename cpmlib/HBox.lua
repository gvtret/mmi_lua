local Control = require('cpmlib.Control')
local HBox = class(Control)

function HBox:init(attrs)
  Control.init(self, attrs)
  self._h = 0 or attrs.h
  self._w = 0 or attrs.w
  self.controls = {}
end

function HBox:addControl(control)
  if control == nil then return end
    table.insert(self.controls, control)
  
  if control:getHeight() > self._h then
    self._h = control:getHeight()
  elseif control:getHeight() < self._h then
    control:setHeight(self._h)
  end
  control:setParent(self)
end
return HBox