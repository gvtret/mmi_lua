local test = require ('u-test.u-test')
local eventmap_name = 'templates/Events.xml'
local eventProvider = cpmlib.EventProvider(eventmap_name, 'RU', cpmlib.Log())

--- Scancodes for keys
local Keys = {
  no_key = -1,
  close = 1,
  trip = 2,
  enter = 3,
  esc = 4,
  up = 5,
  down = 6,
  left = 7,
  right = 8,
  one = 9,
  two = 10,
  three = 11,
  four = 12,
  five = 13,
  six = 14,
  seven = 15,
  eight = 16,
  nine = 17,
  loc = 18,
  zero = 19,
  dot = 20,
}

--- test class for main window
local Callback = function()
  cpmlib.Log:print(3, 'Event fired')
  return true
end
Window = {
  IsActive = false,
  Events = {
    onClosePressed = Callback,
    onCloseHeld = Callback,
    onCloseLongHeld = Callback,
    onCloseReleased = Callback,
    onTripPressed = Callback,
    onTripHeld = Callback,
    onTripLongHeld = Callback,
    onTripReleased = Callback,
    onEnterPressed = Callback,
    onEnterHeld = Callback,
    onEnterLongHeld = Callback,
    onEnterReleased = Callback,
    onShowEventLog = Callback,
    onShowFaultLog = Callback,
    onShowMeData = Callback,
    onAR = Callback,
    onABR = Callback,
    onSEF = Callback,
    onEF = Callback,
    onCustom1 = Callback,
    onCustom2 = Callback,
    onCustom3 = Callback,
    onSwitchMode = Callback,
    onHotLine = Callback,
    onGroupChange = Callback,
   },
}

--- test class for menu
Menu = {
  IsActive = false,
  Events = {
    onShowSubmenu = Callback,
    onExitSubmenu = Callback,
    onMainmenu = Callback,
    onMoveUp = Callback,
    onMoveFirst = Callback,
    onMoveDown = Callback,
    onMoveLast = Callback,
  },
}

--- test class for editable element
Edit = {Events = {}}

--- test class for table
Table = {Events = {}}

test.EventProvider.start_up = function ()
  for k, v in pairs(Window.Events) do
    eventProvider:connect(k, v)
  end
  for k, v in pairs(Menu.Events) do
    eventProvider:connect(k, v)
  end
end

test.EventProvider.init_test = function()
  test.is_not_nil(eventProvider)
  Window.IsActive = true
  Menu.IsActive = true
end

test.EventProvider.close_pressed_released = function ()
  eventProvider:loop(Keys.close)
  test.is_true(eventProvider:getCallback('onClosePressed').fired)
  eventProvider:loop(Keys.no_key)
  test.is_false(eventProvider:getCallback('onClosePressed').fired)
  test.is_true(eventProvider:getCallback('onCloseReleased').fired)
  eventProvider:loop(Keys.no_key)
  test.is_false(eventProvider:getCallback('onCloseReleased').fired)
end

test.EventProvider.close_held = function ()
  local start = os.clock()
  eventProvider:loop(Keys.close)
  while (not eventProvider:getCallback('onCloseHeld').fired) do
    eventProvider:loop(Keys.close)
  end
  local diff = os.clock() - start
  test.almost_equal(1, diff, 0.99)
  eventProvider:loop(Keys.no_key)
  test.is_false(eventProvider:getCallback('onCloseHeld').fired)
  test.is_true(eventProvider:getCallback('onCloseReleased').fired)
end

test.EventProvider.close_long_held = function ()
  local start = os.clock()
  eventProvider:loop(Keys.close)
  while (not eventProvider:getCallback('onCloseLongHeld').fired) do
    eventProvider:loop(Keys.close)
  end
  local diff = os.clock() - start
  test.almost_equal(5, diff, 0.99)
  eventProvider:loop(Keys.no_key)
  test.is_false(eventProvider:getCallback('onCloseLongHeld').fired)
  test.is_true(eventProvider:getCallback('onCloseReleased').fired)
end

test.EventProvider.trip_pressed_released = function ()
  eventProvider:loop(Keys.trip)
  test.is_true(eventProvider:getCallback('onTripPressed').fired)
  eventProvider:loop(Keys.no_key)
  test.is_false(eventProvider:getCallback('onTripPressed').fired)
  test.is_true(eventProvider:getCallback('onTripReleased').fired)
  eventProvider:loop(Keys.no_key)
  test.is_false(eventProvider:getCallback('onTripReleased').fired)
end

test.EventProvider.trip_held = function ()
  local start = os.clock()
  eventProvider:loop(Keys.trip)
  while (not eventProvider:getCallback('onTripHeld').fired) do
    eventProvider:loop(Keys.trip)
  end
  local diff = os.clock() - start
  test.almost_equal(1, diff, 0.99)
  eventProvider:loop(Keys.no_key)
  test.is_false(eventProvider:getCallback('onTripHeld').fired)
  test.is_true(eventProvider:getCallback('onTripReleased').fired)
end

test.EventProvider.trip_long_held = function ()
  local start = os.clock()
  eventProvider:loop(Keys.trip)
  while (not eventProvider:getCallback('onTripLongHeld').fired) do
    eventProvider:loop(Keys.trip)
  end
  local diff = os.clock() - start
  test.almost_equal(5, diff, 0.99)
  eventProvider:loop(Keys.no_key)
  test.is_false(eventProvider:getCallback('onTripLongHeld').fired)
  test.is_true(eventProvider:getCallback('onTripReleased').fired)
end

test.EventProvider.enter_pressed_released = function ()
  eventProvider:loop(Keys.enter)
  if Menu.IsActive then
    test.is_true(eventProvider:getCallback('onShowSubmenu').fired)
    eventProvider:loop(Keys.no_key)
    test.is_false(eventProvider:getCallback('onShowSubmenu').fired)
   else
   for k, v in pairs(eventProvider._callback) do
      test.is_false(v.fired)
   end
 end
end

test.EventProvider.enter_held = function ()
  local start = os.clock()
  eventProvider:loop(Keys.enter)
  while (not eventProvider:getCallback('onEnterHeld').fired) do
    eventProvider:loop(Keys.enter)
  end
  local diff = os.clock() - start
  test.almost_equal(1, diff, 0.99)
  eventProvider:loop(Keys.no_key)
  test.is_false(eventProvider:getCallback('onEnterHeld').fired)
  test.is_true(eventProvider:getCallback('onEnterReleased').fired)
end

test.EventProvider.enter_long_held = function ()
  local start = os.clock()
  eventProvider:loop(Keys.enter)
  while (not eventProvider:getCallback('onEnterLongHeld').fired) do
    eventProvider:loop(Keys.enter)
  end
  local diff = os.clock() - start
  test.almost_equal(5, diff, 0.99)
  eventProvider:loop(Keys.no_key)
  test.is_false(eventProvider:getCallback('onEnterLongHeld').fired)
  test.is_true(eventProvider:getCallback('onEnterReleased').fired)
end

test.summary()



