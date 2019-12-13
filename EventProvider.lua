local Timer = require ('Timer')
local xml2lua = require('xml2lua.xml2lua')

local EventProvider = {}
EventProvider.new = function(filename, locale)
  --start
  local self = {}
  if filename == '' then
    error('Must provide name of file with event map description to ctor')
    return nil
  end
  local _className = 'EventProvider'
  local _xml = xml2lua.loadFile(filename)
  local _tree = require('xml2lua.xmlhandler.tree')
  local _log = io.open('EventProvider.log','w')
  local _locale = locale
  local _timers = {}
  local _callback = {}
  local _prev_scancode = -1
  xml2lua.parser(_tree):parse(_xml)

  --private members
  local _process_pressed = function(scancode)
    for _, _v in pairs(_tree.root.Keymap.Key) do
      if tonumber(_v._attr.scancode) == scancode then
        if type(_v.Pressed) ~= 'table' and _v.Pressed ~= '' then
          _callback[_v.Pressed].fired = _callback[_v.Pressed].cb(_callback[_v.Pressed].sender, _v._attr)
        else
          for _k1, _v1 in pairs(_v.Pressed) do
            if _v1 ~= '' and _callback[_v1] ~= nil then
              _callback[_v1].fired = _callback[_v1].cb(_callback[_v1].sender, _v._attr)
            end
          end
        end
      end
    end
  end

  local _process_held = function(scancode)
    for _, _v in pairs(_tree.root.Keymap.Key) do
      if tonumber(_v._attr.scancode) == scancode then
        if type(_v.Held) ~= 'table'  and _v.Held ~= '' then
          if _timers[_v._attr.timeout] == nil then
            _timers[_v._attr.timeout] = Timer.new(tonumber(_v._attr.timeout),_callback[_v.Held].cb)
            _timers[_v._attr.timeout].start()
          else
            _timers[_v._attr.timeout].update()
            _callback[_v.Held].fired = _timers[_v._attr.timeout].getCallbackResult()
          end
        else
          for _k1, _v1 in pairs(_v.Held) do
            if _v1[1] ~= '' and _callback[_v1[1]] ~= nil then
              if _timers[_v1._attr.timeout] == nil then
                _timers[_v1._attr.timeout] = Timer.new(tonumber(v1._attr.timeout),_callback[_v1[1]].cb)
                _timers[_v1._attr.timeout].start()
              else
                _timers[_v1._attr.timeout].update()
                _callback[_v1[1]].fired = _timers[_v1._attr.timeout].getCallbackResult()
              end
            end
          end
        end
      end
    end
  end

  local _process_released = function(scancode)
    for _, _v in pairs(_tree.root.Keymap.Key) do
      if tonumber(_v._attr.scancode) == scancode then
        if type(_v.Released) ~= 'table' and _v.Released ~= '' then
          _callback[_v.Released].fired = _callback[_v.Released].cb(_callback[_v.Released].sender, _v._attr)
        else
          for _, _v1 in pairs(_v.Released) do
            if _v1 ~= '' and _callback[_v1] ~=nil then
              _callback[_v1].fired = _callback[_v1].cb(_callback[_v1].sender, _v._attr)
            end
          end
        end
      end
    end
  
    for _k, _v in pairs(_timers) do
      _timers[_k].stop()
      _timers[_k] = nil
    end
  end

  --public members
  self.connect = function(event, method, sender)
    local callback = {cb = method, fired = false, sender = sender}
    _callback[event] = callback
  end

  self.loop = function(scancode)
    for _k, _v in pairs(_callback) do
      _callback[_k].fired = false
    end
  
    if _prev_scancode == -1 and scancode ~= -1 then 
      _process_pressed(scancode)
    elseif _prev_scancode == scancode and scancode ~= -1 then 
      _process_held(scancode)
    elseif _prev_scancode ~= -1 and scancode == -1 then 
      _process_released(_prev_scancode)
    elseif _prev_scancode ~= scancode and scancode ~= -1 then -- another key pressed
      _process_released(_prev_scancode)
      _process_pressed(scancode)
    end
  
    _prev_scancode = scancode
  end

  --end
  return self  
end

return EventProvider
