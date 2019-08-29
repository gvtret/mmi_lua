--- Timer class
-- @type Timer
Timer = {}
Timer.new = function (interval, on_timer_cb)
  --start
  local self = {}
  -- private
  local _class = 'Timer'
  local _interval = interval
  local _onTimerCallback = on_timer_cb
  local _startTime = 0
  local _stopTime = 0
  local _callbackResult = false
  local _stopped = true
  local _timerFunction = function (cmd)
          while true do
            if cmd == 'stop' then
              _stopTime = os.clock()
              _stopped = true
              break
            end

            if cmd == 'start' then
              _startTime = os.clock()
              _stopTime = 0
              _stopped = false
              _callbackResult = false
            end
      
            if cmd == 'update' then
              local now = os.clock()
              if now - _startTime >= _interval then
                _stopTime = now
                _callbackResult = _onTimerCallback()
                _stopped = true
                break
              end
            end
      
            cmd = coroutine.yield()
          end
        end
  local _coro = coroutine.create(_timerFunction)

  -- public
  --- Start timer
  -- Saves current time as start time of timer.
  -- Resume or create timer function coroutine.
  self.start = function ()
    if coroutine.status(_coro) == 'dead' then
      _coro = coroutine.create(_timerFunction)
    end
    coroutine.resume(_coro, 'start')
  end

  --- Refresh timer
  -- Resume timer function couroutine.
  self.update = function ()
    if coroutine.status(_coro) ~= 'dead' then
      coroutine.resume(_coro, 'update')
    end
  end

  --- Stop timer
  -- Stop execution of timer function coroutine
  self.stop = function ()
    if coroutine.status(_coro) ~= 'dead' then
      coroutine.resume(_coro, 'stop')
    end
  end

  self.getCallbackResult = function ()
    return _callbackResult
  end

  self.isStopped = function ()
    return _stopped
  end

  --end
  return self  
end
