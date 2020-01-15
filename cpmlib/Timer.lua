--- Timer class
-- @type Timer
local Timer = class()

function Timer:init(interval, on_timer_cb, logger)
  assert(logger, '\'logger\' parameter not specified!')
  assert(interval, '\'interval\' parameter not specified!')
  assert(on_timer_cb, '\'on_timer_cb\' parameter not specified!')
  self._interval = interval
  self._onTimerCallback = on_timer_cb
  self._startTime = 0
  self._stopTime = 0
  self._callbackResult = false
  self._stopped = true
  self._logger = logger
  self._coroutine = coroutine.create(self._timerFunction)
  coroutine.resume(self._coroutine, self, '')
 end
 
function Timer:_timerFunction(cmd)
  local now = nil
  while true do
    now = os.clock()
    if cmd == 'stop' then
      self._stopTime = now
      self._stopped = true
      break
    end

    if cmd == 'start' then
      self._startTime = now
      self._stopTime = 0
      self._stopped = false
      self._callbackResult = false
    end

    if cmd == 'update' then
      if now - self._startTime >= self._interval then
        self._callbackResult = self._onTimerCallback()
      end
    end
    cmd = coroutine.yield()
  end
end
  
function Timer:start()
  if coroutine.status(self._coroutine) == 'dead' then
    self._coroutine = coroutine.create(self._timerFunction)
    coroutine.resume(self._coroutine, self, '')
  end
  coroutine.resume(self._coroutine, 'start')
end

--- Refresh timer
-- Resume timer function couroutine.
function Timer:update()
  if coroutine.status(self._coroutine) ~= 'dead' then
    coroutine.resume(self._coroutine, 'update')
  end
end

--- Stop timer
-- Stop execution of timer function coroutine
function Timer:stop()
  if coroutine.status(self._coroutine) ~= 'dead' then
    coroutine.resume(self._coroutine, 'stop')
  end
end

function Timer:getCallbackResult()
  return self._callbackResult
end

function Timer:isStopped()
  return self._stopped
end

return Timer
