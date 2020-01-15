-- Line class
local Control = require ('cpmlib.Control')
local Line = class (Control)

function Line:init(attrs, logger)
  Control.init(self, attrs, logger)
  self._funcId = 0x01
  self._x1 = 0 or attrs.x1
  self._y1 = 0 or attrs.y1
  self._x2 = 0 or attrs.x1
  self._y2 = 0 or attrs.y1
  self:draw()
end

function Line:setStart(x, y)
  self._x1 = x
  self._y1 = y
  self:draw()
end

function Line:getStart()
  return self._x1, self._y1
end

function Line:setEnd(x, y)
  self._x2 = x
  self._y2 = y
  self:draw()
end

function Line:getEnd()
  return self._x2, self._y2
end

function Line:draw()
  self._buffer = struct.pack('BBHHHH', 
                              self._funcId,
                              bit32.bor(bit32.lshift(self._background,4), self._foreground),
                              self._x1, self._y1, self._x2, self._y2)
end

return Line
