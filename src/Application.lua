require ('utils')
require ('Icon')
require ('Timer')
require ('Text')
require ('List')
require ('User')
require ('Edit')

Application = {}
Application.new = function(eventProvider, templEngine)
  --start
  local self = {}
  if eventProvider == nil or templEngine == nil then
    error('Must provide instances of EventProvider and TemplateEngine to ctor')
    return nil
  end

  --private members
  local _gui = require('termfx')
  local _utf8 = require ('utf8')
  local _running = true
  local _eventProvider = eventProvider
  local _templEngine = templEngine
  local _user = User.new('None')
  local _controlStack = {}
  local _timers = {}
  local _screen = {
      height = 8,
      width = 64,
      titleBar = {},
      mainFrame = {},
      statusBar = {}
  }
  local _setDateTime = true
  local _objectPool = {}

  local _updateTimers = function()
    for _, _v in pairs(_timers) do _v.update() end
  end

  local _draw = function()
    local _s = ''
    local _start = _utf8.char(tblSigns.bold.LTPC)
    local _mid = _utf8.char(tblSigns.bold.HORL):rep(64)
    local _end = _utf8.char(tblSigns.bold.RTPC)
    _s = _start.._mid.._end
    _gui.printat(1, 1, _s)
    _start = _utf8.char(tblSigns.bold.VERL)
    _gui.printat(1, 2, _start)
    self.drawTitleBar()
    _end = _utf8.char(tblSigns.bold.VERL)
    _gui.printat(_screen.width + 2, 2, _end)
    _start = _utf8.char(tblSigns.bold.LCRS)
    _mid = _utf8.char(tblSigns.bold.HORL):rep(64)
    _end = _utf8.char(tblSigns.bold.RCRS)
    _s = _start.._mid.._end
    _gui.printat(1, 3, _s)
    for _i, _v in ipairs(_screen.mainFrame.drawText()) do
      _start = _utf8.char(tblSigns.bold.VERL)
      _mid = _v
      _end = _utf8.char(tblSigns.bold.VERL)
      _s = _start.._mid.._end
      _gui.printat(1, 3 + _i, _s)
    end
    _start = _utf8.char(tblSigns.bold.LCRS)
    _mid = _utf8.char(tblSigns.bold.HORL):rep(64)
    _end = _utf8.char(tblSigns.bold.RCRS)
    _s = _start.._mid.._end
    _gui.printat(1, 8, _s)
    self.setDateTime()
  
    _start = _utf8.char(tblSigns.bold.VERL)
    _gui.printat(1, 9, _start)
    self.drawStatusBar()
    _end = _utf8.char(tblSigns.bold.VERL)
    _gui.printat(_screen.width + 2, 9, _end)
    _start = _utf8.char(tblSigns.bold.LBMC)
    _mid = _utf8.char(tblSigns.bold.HORL):rep(64)
    _end = _utf8.char(tblSigns.bold.RBMC)
    _s = _start.._mid.._end
    _gui.printat(1, 10, _s)
  end
  
  self._connectEvents = function(object)
    for k, v in pairs(object) do
      if k:sub(1,2) == 'on' then
        _eventProvider.connect(k, v, self)
      end
    end
  end
  
  self._checkTimers = function(skip_timer)
    for k, v in pairs(_timers) do
      if k ~= skip_timer then v.stop() end
    end
  end 
  
  self._inObjectPool = function(object_name)
    for k, v in pairs(_objectPool) do
      if k == object_name then return true end
    end
    return false
  end
  
  --public members
  self.init = function ()
    _gui.init()
    _gui.clear(_gui.color.GREEN, _gui.color.BLACK)  
    self._connectEvents(self)
    _screen.titleBar[1] = Icon.new(nil, 'logo')
    self._connectEvents(_screen.titleBar[1])
    _screen.titleBar[3] = Icon.new(nil, 'menu')
    self._connectEvents(_screen.titleBar[3])
    _screen.titleBar[2] = Text.new(nil, menus[1].name)
    self._connectEvents(_screen.titleBar[2])
    _screen.titleBar[2].setAlign('center')
    _screen.titleBar[2].setMaxSize(_screen.width - (_screen.titleBar[1].getSize() + _screen.titleBar[3].getSize()))
    if not self._inObjectPool(menus[1].name) then
      _objectPool[menus[1].name] = _templEngine.build(menus[1].templ, menus[1].name)
    end
    _screen.mainFrame = _objectPool[menus[1].name]
    _screen.mainFrame.setFocused(true)
    self._connectEvents(_screen.mainFrame)
    _screen.titleBar[3].setType(_screen.mainFrame.getItem(1).ref_type)
    _screen.statusBar[1] = Text.new(nil,'')
    self._connectEvents(_screen.statusBar[1])
    _screen.statusBar[1].setAlign('center')
    _screen.statusBar[1].setMaxSize(_screen.width)
    self.setDescription(_screen.mainFrame.getSelectedItem().ref.desc)
  end
  
  self.stop = function()
    _gui.shutdown()
  end
  
  self.loop = function()
    while _running do
      local evt = _gui.pollevent(1)
      if evt ~= nil then
        _gui.clear(_gui.color.GREEN, _gui.color.BLACK)
  
        if evt.key == _gui.key.ESC then _eventProvider.loop(4)
        elseif evt.key == _gui.key.ENTER then _eventProvider.loop(3)
        elseif evt.key == _gui.key.ARROW_UP then _eventProvider.loop(5)
        elseif evt.key == _gui.key.ARROW_DOWN then _eventProvider.loop(6)
        elseif evt.key == _gui.key.ARROW_LEFT then _eventProvider.loop(7)
        elseif evt.key == _gui.key.ARROW_RIGHT then _eventProvider.loop(8)
        elseif evt.char == 'c' then _eventProvider.loop(1)
        elseif evt.char == 't' then _eventProvider.loop(2)
        elseif evt.char == '1' then _eventProvider.loop(9)
        elseif evt.char == '2' then _eventProvider.loop(10)
        elseif evt.char == '3' then _eventProvider.loop(11)
        elseif evt.char == '4' then _eventProvider.loop(12)
        elseif evt.char == '5' then _eventProvider.loop(13)
        elseif evt.char == '6' then _eventProvider.loop(14)
        elseif evt.char == '7' then _eventProvider.loop(15)
        elseif evt.char == '8' then _eventProvider.loop(16)
        elseif evt.char == '9' then _eventProvider.loop(17)
        elseif evt.char == 'l' then _eventProvider.loop(18)
        elseif evt.char == '0' then _eventProvider.loop(19)
        elseif evt.char == '.' then _eventProvider.loop(20)
        elseif evt.char == 'q' then _running = false
        else
          _eventProvider.loop(-1)
        end
        _eventProvider.loop(-1)
      end
      _updateTimers()
      _draw()
      _gui.present()
    end
  end

  self.setCtxIconType = function(icon_type)
    _screen.titleBar[3].setType(icon_type)
  end
  
  self.showMenu = function(name)
    if not self._inObjectPool(name) then
      _objectPool[name] = _templEngine.build(_screen.mainFrame.getSelectedItem().ref.templ, name)
    end 
    _screen.mainFrame = _objectPool[name] 
    _screen.mainFrame.setFocused(true)
    _screen.titleBar[2].setValue(_screen.mainFrame.name)
    self.setDescription(_screen.mainFrame.getSelectedItem().ref.desc)
    self._connectEvents(_screen.mainFrame)
  end
  
  self.setTitle = function(value)
    _screen.titleBar[2].setValue(value)
  end
  
  self.setDateTime = function()
    local timers_stopped = true
    for k, v in pairs(_timers) do
      timers_stopped = timers_stopped and v.isStopped()
    end

    if timers_stopped  and _setDateTime then
      _screen.statusBar[1].setAlign("center")
      _screen.statusBar[1].setMaxSize(_screen.width)
      _screen.statusBar[1].setValue(os.date())
    end
  end
  
  self.setDescription = function(desc)
    if desc == nil or desc == '' then 
      _setDateTime = true
      self._checkTimers()
      return
    end
    _screen.statusBar[1].setAlign("center")
    _screen.statusBar[1].setMaxSize(_screen.width)
    _screen.statusBar[1].setValue(desc)
    if _timers[timer_name.showDesc] == nil then
      _timers[timer_name.showDesc] = Timer.new(5, self.onTimerShowDesc)
    end
    _timers[timer_name.showDesc].start()
    self._checkTimers(timer_name.showDesc)
  end

  self.checkPermission = function()
    if _user.checkPermission(_screen.mainFrame.getSelectedItem().permission) then
      self.showMenu(_screen.mainFrame.getSelectedItem().name)
    else
      self.askPassword(_screen.mainFrame.getSelectedItem().permission)
    end
  end  

  self.askPassword = function(permission)
    local username = User.getNames(permission)
    _screen.statusBar[1].setValue("Enter "..username.." password: ")
    _screen.statusBar[1].setAlign("left")
    _screen.statusBar[2] = Edit.new(nil, true, 6)
    _screen.statusBar[1].setMaxSize(_screen.width - _screen.statusBar[2].getSize())
    self._connectEvents(_screen.statusBar[2])
    _screen.statusBar[2].setFocused(true)
    _screen.mainFrame.setFocused(false)
    _setDateTime = false
  end
  
  self.cancelPassword = function()
    _screen.statusBar[1].setValue("Cancelled")
    _screen.statusBar[1].setAlign("center")
    _screen.statusBar[1].setMaxSize(_screen.width)
    _screen.statusBar[2].setFocused(false)
    _screen.mainFrame.setFocused(true)
    if _timers[timer_name.cancelled] == nil then
      _timers[timer_name.cancelled] = Timer.new(1, self.onTimerCancelled)
    end
    _timers[timer_name.cancelled].start()
    self._checkTimers(timer_name.cancelled)
  end
  
  self.loginUser = function(password)
    _screen.statusBar[2].setFocused(false)
    _screen.mainFrame.setFocused(true)
    if _user.logIn(password) then
      self.checkPermission()
    else
      self.wrongPassword()
    end
  end
  
  self.wrongPassword = function()
    _screen.statusBar[1].setValue('Invalid password')
    _screen.statusBar[1].setAlign("center")
    _screen.statusBar[1].setMaxSize(_screen.width)
    if _timers[timer_name.invalid] == nil then
      _timers[timer_name.invalid] = Timer.new(1, self.onTimerInvalid)
    end
    _timers[timer_name.invalid].start()
    self._checkTimers(timer_name.invalid)
    
  end
  
  self.drawStatusBar = function()
    local start_x = 2 -- from second row in line
    local start_y = 9 -- from second line
    for _, v in pairs(_screen.statusBar) do
      if v.getVisible()then
        local buff = _gui.newbuffer(v.getSize(), 1)
        v.draw(buff)
        _gui.blit(start_x, start_y, buff)
        start_x = start_x + v.getSize()
      end
    end 
  end

  self.drawTitleBar = function()
    local start_x = 2 -- from second row in line
    local start_y = 2 -- from second line
    for _, v in pairs(_screen.titleBar) do
      if v.getVisible()then
        local buff = _gui.newbuffer(v.getSize(), 1)
        v.draw(buff)
        _gui.blit(start_x, start_y, buff)
        start_x = start_x + v.getSize()
      end
    end 
  end

  self.drawMainFrame = function()
  end

  self.onTimerCancelled = function()
    _timers[timer_name.cancelled].stop()
    _setDateTime = true
    return true
  end

  self.onTimerInvalid = function()
    _timers[timer_name.invalid].stop()
    _setDateTime = true
    return true
  end
  
  self.onTimerShowDesc = function()
    _timers[timer_name.showDesc].stop()
    _setDateTime = true
    return true
  end

  --end
  return self
end



