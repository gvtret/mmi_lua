local Control = require('cpmlib.Control')
local VBox = class(Control)

function VBox:init(attrs, logger)
  Control.init(self, attrs, logger)
  self._h = 0 or attrs.h
  self._w = 0 or attrs.w
  self.controls = {}
end

function VBox:addControl(control)
  if control == nil then return end
    table.insert(self.controls, control)
  
  if control:getHeight() > self._h then
    self._h = control:getHeight()
  elseif control:getHeight() < self._h then
    control:setHeight(self._h)
  end
  control:setParent(self)
end

return VBox


