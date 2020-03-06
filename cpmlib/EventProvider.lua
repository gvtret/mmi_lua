local Timer = require ('cpmlib.Timer')
local xml2lua = require('xml2lua.xml2lua')

local EventProvider = class()

function EventProvider:init(filename, locale, logger)
  if filename == '' then
    logger:print(1, 'Must provide name of file with event map description to ctor')
    return nil
  end
  self._className = 'EventProvider'
  self._xml = xml2lua.loadFile(filename)
  self._tree = require('xml2lua.xmlhandler.tree')
  self._log = io.open('EventProvider.log','w')
  self._locale = locale
  self._timers = {}
  self._callback = {}
  self._prev_scancode = -1
  self._logger = logger
  xml2lua.parser(self._tree):parse(self._xml)
end

--Private members
function EventProvider:_process_pressed(scancode)
  for _, _v in pairs(self._tree.root.Keymap.Key) do
    if tonumber(_v._attr.scancode) == scancode then
      if type(_v.Pressed) ~= 'table' and _v.Pressed ~= '' then
        self._callback[_v.Pressed].fired = self._callback[_v.Pressed].cb(self._callback[_v.Pressed].sender, _v._attr)
      else
        for _k1, _v1 in pairs(_v.Pressed) do
          if _v1 ~= '' and self._callback[_v1] ~= nil then
            self._callback[_v1].fired = self._callback[_v1].cb(self._callback[_v1].sender, _v._attr)
          end
        end
      end
    end
  end
end
  
function EventProvider:_process_held(scancode)
  for _, _v in pairs(self._tree.root.Keymap.Key) do
    if tonumber(_v._attr.scancode) == scancode then
      if type(_v.Held) ~= 'table'  and _v.Held ~= '' then
        if self._timers[_v._attr.timeout] == nil then
          self._timers[_v._attr.timeout] = Timer(tonumber(_v._attr.timeout),self._callback[_v.Held].cb, self._logger)
          self._timers[_v._attr.timeout]:start()
        else
          self._timers[_v._attr.timeout]:update()
          self._callback[_v.Held].fired = self._timers[_v._attr.timeout]:getCallbackResult()
        end
      else
        for _k1, _v1 in pairs(_v.Held) do
          if _v1[1] ~= '' and self._callback[_v1[1]] ~= nil then
            if self._timers[_v1._attr.timeout] == nil then
              self._timers[_v1._attr.timeout] = Timer(tonumber(_v1._attr.timeout),self._callback[_v1[1]].cb, self._logger)
              self._timers[_v1._attr.timeout]:start()
            else
              self._timers[_v1._attr.timeout]:update()
              self._callback[_v1[1]].fired = self._timers[_v1._attr.timeout]:getCallbackResult()
            end
          end
        end
      end
    end
  end
end
  
function EventProvider:_process_released(scancode)
  for _, _v in pairs(self._tree.root.Keymap.Key) do
    if tonumber(_v._attr.scancode) == scancode then
      if type(_v.Released) ~= 'table' and _v.Released ~= '' then
        self._callback[_v.Released].fired = self._callback[_v.Released].cb(self._callback[_v.Released].sender, _v._attr)
      else
        for _, _v1 in pairs(_v.Released) do
          if _v1 ~= '' and self._callback[_v1] ~=nil then
            self._callback[_v1].fired = self._callback[_v1].cb(self._callback[_v1].sender, _v._attr)
          end
        end
      end
    end
  end

  for _k, _v in pairs(self._timers) do
    self._timers[_k]:stop()
    self._timers[_k] = nil
  end
end

--Public members
function EventProvider:connect(event, method, sender)
  local callback = {cb = method, fired = false, sender = sender}
  self._callback[event] = callback
end

function EventProvider:loop(scancode)
  for _k, _v in pairs(self._callback) do
    self._callback[_k].fired = false
  end

  if self._prev_scancode == -1 and scancode ~= -1 then 
    self:_process_pressed(scancode)
  elseif self._prev_scancode == scancode and scancode ~= -1 then 
    self:_process_held(scancode)
  elseif self._prev_scancode ~= -1 and scancode == -1 then 
    self:_process_released(self._prev_scancode)
  elseif self._prev_scancode ~= scancode and scancode ~= -1 then -- another key pressed
    self:_process_released(self._prev_scancode)
    self:_process_pressed(scancode)
  end

  self._prev_scancode = scancode
end

function EventProvider:getCallback(cb_name)
  if self._callback[cb_name] == nil then
    self._logger:print(2, 'Callback "'..cb_name..'" was not provided.')
    return {fired=true, cb = nil, sender = nil}
  end
  return self._callback[cb_name]
end
--[[




  --end
  return self  
end
--]]

return EventProvider
