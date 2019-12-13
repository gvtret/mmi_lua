-- Text class
local Control = require("cpmlib.Control")
local Text = class(Control)

function Text:init(attrs)
  Control.init(self, attrs)
  self._align = 'left' or attrs.align
  self._gh = 8 or attrs.gh
  self._gw = 6 or attrs.gw
  self._text = ''
end

function Text:setGlythSize(h, w)
  if h == nil or w == nil then return end
  self._gh = h
  self._gw = w
  self:draw()
end

function Text:setAligh(align)
  if align == nil or align == '' then return end
  self._align = align
  self:draw()
end

function Text:setText(str)
  if str == nil then return end
  self._text = str
  self:draw()
end

function Text:draw()
  if self._align == 'center' then
  
  elseif self._align == 'left' then
  elseif self._align == 'right' then
  end
end
