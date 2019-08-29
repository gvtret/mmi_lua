package.path = package.path..';./src/?.lua'..';./src/xml2lua/?.lua'..';./src/u-test/?.lua'
require('EventProvider')
local test = require ('u-test.u-test')
local eventProvider = nil
local eventmap_name = 'src/Events.xml'

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
Window = {
  IsActive = false,
  Events = {
    onClosePressed = function () return Window.IsActive end,
    onCloseHeld = function () return Window.IsActive end,
    onCloseLongHeld = function () return Window.IsActive end,
    onCloseReleased = function () return Window.IsActive end,
    onTripPressed = function () return Window.IsActive end,
    onTripHeld = function () return Window.IsActive end,
    onTripLongHeld = function () return Window.IsActive end,
    onTripReleased = function () return Window.IsActive end,
    onShowEventLog = function () return Window.IsActive end,
    onShowFaultLog = function () return Window.IsActive end,
    onShowMeData = function () return Window.IsActive end,
    onAR = function () return Window.IsActive end,
    onABR = function () return Window.IsActive end,
    onSEF = function () return Window.IsActive end,
    onEF = function () return Window.IsActive end,
    onCustom1 = function () return Window.IsActive end,
    onCustom2 = function () return Window.IsActive end,
    onCustom3 = function () return Window.IsActive end,
    onSwitchMode = function () return Window.IsActive end,
    onHotLine = function () return Window.IsActive end,
    onGroupChange = function () return Window.IsActive end,
   },
}

--- test class for menu
Menu = {
  IsActive = false,
  Events = {
    onShowSubmenu = function () return Menu.IsActive end,
    onExitSubmenu = function () return Menu.IsActive end,
    onMainmenu = function () return Menu.IsActive end,
    onMoveUp = function () return Menu.IsActive end,
    onMoveFirst = function () return Menu.IsActive end,
    onMoveDown = function () return Menu.IsActive end,
    onMoveLast = function () return Menu.IsActive end,
  },
}

--- test class for editable element
Edit = {Events = {}}

--- test class for table
Table = {Events = {}}

test.EventProvider.start_up = function ()
  eventProvider = EventProvider(eventmap_name,'RU')
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
end

test.EventProvider.close_pressed_released = function ()
  eventProvider:loop(Keys.close)
  test.is_true(eventProvider.callback.onClosePressed.fired)
  eventProvider:loop(Keys.no_key)
  test.is_false(eventProvider.callback.onClosePressed.fired)
  test.is_true(eventProvider.callback.onCloseReleased.fired)
  eventProvider:loop(Keys.no_key)
  test.is_false(eventProvider.callback.onCloseReleased.fired)
end

test.EventProvider.close_held = function ()
  local start = os.clock()
  eventProvider:loop(Keys.close)
  while (not eventProvider.callback.onCloseHeld.fired) do
    eventProvider:loop(Keys.close)
  end
  local diff = os.clock() - start
  test.almost_equal(1, diff, 0.99)
  eventProvider:loop(Keys.no_key)
  test.is_false(eventProvider.callback.onCloseHeld.fired)
  test.is_true(eventProvider.callback.onCloseReleased.fired)
end

test.EventProvider.close_long_held = function ()
  local start = os.clock()
  eventProvider:loop(Keys.close)
  while (not eventProvider.callback.onCloseLongHeld.fired) do
    eventProvider:loop(Keys.close)
  end
  local diff = os.clock() - start
  test.almost_equal(5, diff, 0.99)
  eventProvider:loop(Keys.no_key)
  test.is_false(eventProvider.callback.onCloseLongHeld.fired)
  test.is_true(eventProvider.callback.onCloseReleased.fired)
end

test.EventProvider.trip_pressed_released = function ()
  eventProvider:loop(Keys.trip)
  test.is_true(eventProvider.callback.onTripPressed.fired)
  eventProvider:loop(Keys.no_key)
  test.is_false(eventProvider.callback.onTripPressed.fired)
  test.is_true(eventProvider.callback.onTripReleased.fired)
  eventProvider:loop(Keys.no_key)
  test.is_false(eventProvider.callback.onTripReleased.fired)
end

test.EventProvider.trip_held = function ()
  local start = os.clock()
  eventProvider:loop(Keys.trip)
  while (not eventProvider.callback.onTripHeld.fired) do
    eventProvider:loop(Keys.trip)
  end
  local diff = os.clock() - start
  test.almost_equal(1, diff, 0.99)
  eventProvider:loop(Keys.no_key)
  test.is_false(eventProvider.callback.onTripHeld.fired)
  test.is_true(eventProvider.callback.onTripReleased.fired)
end

test.EventProvider.trip_long_held = function ()
  local start = os.clock()
  eventProvider:loop(Keys.trip)
  while (not eventProvider.callback.onTripLongHeld.fired) do
    eventProvider:loop(Keys.trip)
  end
  local diff = os.clock() - start
  test.almost_equal(5, diff, 0.99)
  eventProvider:loop(Keys.no_key)
  test.is_false(eventProvider.callback.onTripLongHeld.fired)
  test.is_true(eventProvider.callback.onTripReleased.fired)
end

test.EventProvider.enter_pressed_released = function ()
  eventProvider:loop(Keys.enter)
  if Menu.IsActive then
    test.is_true(eventProvider.callback.onSubmenu.fired)
    eventProvider:loop(Keys.no_key)
    test.is_false(eventProvider.callback.onSubmenu.fired)
   else
   for k, v in pairs(eventProvider.callback) do
      test.is_false(v.fired)
   end
 end
end

test.EventProvider.enter_held = function ()
  local start = os.clock()
  eventProvider:loop(Keys.enter)
  while (not eventProvider.callback.onEnterHeld.fired) do
    eventProvider:loop(Keys.enter)
  end
  local diff = os.clock() - start
  test.almost_equal(1, diff, 0.99)
  eventProvider:loop(Keys.no_key)
  test.is_false(eventProvider.callback.onEnterHeld.fired)
  test.is_true(eventProvider.callback.onEnterReleased.fired)
end

test.EventProvider.enter_long_held = function ()
  local start = os.clock()
  eventProvider:loop(Keys.enter)
  while (not eventProvider.callback.onEnterLongHeld.fired) do
    eventProvider:loop(Keys.enter)
  end
  local diff = os.clock() - start
  test.almost_equal(5, diff, 0.99)
  eventProvider:loop(Keys.no_key)
  test.is_false(eventProvider.callback.onEnterLongHeld.fired)
  test.is_true(eventProvider.callback.onEnterReleased.fired)
end

test.summary()



