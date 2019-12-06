-- Line class
local Line = extends(require('newControl'))

function Line:_init(attr)
  self._class = "Line"
  self._x1 = 0
  self._y1 = 0
  self._x2 = 0
  self._y2 = 0
  self._fg = 15
  self._bg = 0
  self:superClass():_init(attr)
end

function Line:setStart(x, y)
  self._x1 = x
  self._y1 = y
end

function Line:getStart()
  return self._x1, self._y1
end

return Line