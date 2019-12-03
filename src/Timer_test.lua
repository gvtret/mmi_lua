package.path = package.path..';./src/?.lua'
require ('Timer')
local test = require('u-test.u-test')
local timer

local function on_timer()
  return true
end

test.Timer.init_test = function ()
  timer = Timer(5.0, on_timer)
  test.equal(timer.interval, 5.0)
  test.equal(timer.on_timer, on_timer)
  test.equal(coroutine.status(timer.co), 'suspended')
end

test.Timer.start_1_test = function ()
  local now = os.clock()
  timer:start()
  test.almost_equal(now, timer.start_time, 0.99)
  test.equal(coroutine.status(timer.co), 'suspended')
end

test.Timer.fired_1_test = function ()
  while (timer.callback_result ~= true) do
    timer:update()
  end
  local now = os.clock()
  local diff = now - timer.start_time
  test.almost_equal(5.0, diff, 0.99)
  test.equal(coroutine.status(timer.co), 'dead')
end

test.Timer.start_2_test = function ()
  local now = os.clock()
  timer:start()
  test.almost_equal(now, timer.start_time, 0.99)
  test.equal(coroutine.status(timer.co), 'suspended')
end

test.Timer.fired_2_test = function ()
  while (timer.callback_result ~= true) do
    timer:update()
  end
  local now = os.clock()
  local diff = now - timer.start_time
  test.almost_equal(5.0, diff, 0.99)
  test.equal(coroutine.status(timer.co), 'dead')
end

test.Timer.start_3_test = function ()
  local now = os.clock()
  timer:start()
  test.almost_equal(now, timer.start_time, 0.99)
  test.equal(coroutine.status(timer.co), 'suspended')
  timer:update()
end

test.Timer.stop_test = function ()
  timer:stop()
  test.equal(coroutine.status(timer.co), 'dead')
end

test.summary()