local Control = require('cpmlib.Control')
local HBox = class(Control)

function HBox:init(attrs, logger)
  Control.init(self, attrs, logger)
  self.controls = {}
end

function HBox:addControl(control)
  if control == nil then return end
    table.insert(self.controls, control)
  
  if control:getHeight() > self._height then
    self._height = control:getHeight()
  elseif control:getHeight() < self._height then
    control:setHeight(self._height)
  end
  control:setParent(self)
end

return HBox

