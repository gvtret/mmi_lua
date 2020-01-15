local test = require('u-test.u-test')

local function on_timer()
  return true
end
local timer = cpmlib.Timer(5.0, on_timer, require('cpmlib.Log')())

test.Timer.start_1_test = function ()
  local now = os.clock()
  timer:start()
  test.almost_equal(now, timer._startTime, 0.99)
  test.equal(coroutine.status(timer._coroutine), 'suspended')
end

test.Timer.fired_1_test = function ()
  while (timer._callbackResult ~= true) do
    timer:update()
  end
  timer:stop()
  local now = os.clock()
  local diff = now - timer._startTime
  test.almost_equal(5.0, diff, 0.99)
  test.equal(coroutine.status(timer._coroutine), 'dead')
end

test.Timer.start_2_test = function ()
  local now = os.clock()
  timer:start()
  test.almost_equal(now, timer._startTime, 0.99)
  test.equal(coroutine.status(timer._coroutine), 'suspended')
end

test.Timer.fired_2_test = function ()
  while (timer._callbackResult ~= true) do
    timer:update()
  end
  timer:stop()
  local now = os.clock()
  local diff = now - timer._startTime
  test.almost_equal(5.0, diff, 0.99)
  test.equal(coroutine.status(timer._coroutine), 'dead')
end

test.Timer.start_3_test = function ()
  local now = os.clock()
  timer:start()
  test.almost_equal(now, timer._startTime, 0.99)
  test.equal(coroutine.status(timer._coroutine), 'suspended')
  timer:update()
end

test.Timer.stop_test = function ()
  timer:stop()
  test.equal(coroutine.status(timer._coroutine), 'dead')
end

test.result()