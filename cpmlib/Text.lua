-- Text class
local cpm = require('cpm.cpm')
local Control = require('cpmlib.Control')
local Fonts = require('cpmlib.Fonts')
local Text = class(Control)

function Text:init(attrs, logger)
  Control.init(self, attrs, logger)
  self._funcId = 0x03
  self._font = Fonts['5x8']
  self._text = ''
  self._spacing = 1
end

function Text:setFont(name)
  if name == nil or Fonts[name] == nil then return end
  self._font = Fonts[name]
end

function Text:setText(str)
  if str == nil then return end
  self._text = str
  self:draw()
end

function Text:getTextPos()
  local pos_left = self._left
  local pos_top = self._top
  local text_width = #self._text * (self._font.width + self._spacing)
  local text_height = self._font.height
  if self._halign == 'center' then
    pos_left = pos_left + (self._width - text_width) / 2
  elseif self._halign == 'right' then
    pos_left = pos_left + self._width - text_width
  elseif self._halign == 'left' then
    pos_left = self._left
  end
  if self._valign == 'center' then
    pos_top = pos_top + (self._height - text_height) / 2
  elseif self._valign == 'bottom' then
    pos_top = pos_top + self._height - text_height
  elseif self._valign == 'top' then
    pos_top = self._top
  end
  pos_left = pos_left < self._left and self._left or pos_left
  pos_top = pos_top < self._top and self._top or pos_top
  return pos_left, pos_top
end

function Text:draw()
  local left, top = self:getTextPos()
  cpm.drawText(self._funcId, bit32.bor(bit32.lshift(self._background, 4), self._foreground),
                self._text, left, top)
end

return Text
