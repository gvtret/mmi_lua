-- Line class
local Control = require ('cpmlib.Control')
local Line = class (Control)

function Line:init(attrs)
  Control.init(self, attrs)
  self._funcId = 0x01
  self._r = 0 or attrs.r
  self._b = 0 or attrs.b
  self:draw()
end

function Line:setStart(x, y)
  self._l = x
  self._t = y
  self:draw()
end

function Line:getStart()
  return self._l, self._t
end

function Line:setEnd(x, y)
  self._r = x
  self._b = y
  self:draw()
end

function Line:getEnd()
  return self._r, self._b
end

function Line:draw()
  self._buffer = struct.pack('BBHHHH', 
                              self._funcId,
                              bit32.bor(bit32.lshift(self._bg,4), self._fg),
                              self._l, self._t, self._r, self._b)
end

return Line
