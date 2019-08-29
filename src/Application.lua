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
    --s = string.rep('-',_screen.width)
    self.setDescription('datetime')
  
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
  
  --public members
  self.init = function ()
    _gui.init()
    _gui.clear(_gui.color.GREEN, _gui.color.BLACK)  
    self._connectEvents(self)
    _screen.titleBar[1] = Icon.new(nil, 'logo')
    self._connectEvents(_screen.titleBar[1])
    _screen.titleBar[3] = Icon.new(nil, 'menu')
    self._connectEvents(_screen.titleBar[3])
    _screen.titleBar[2] = Text.new(nil, 'Main Menu')
    self._connectEvents(_screen.titleBar[2])
    _screen.titleBar[2].setAlign('center')
    _screen.titleBar[2].setMaxSize(_screen.width - (_screen.titleBar[1].getSize() + _screen.titleBar[3].getSize()))
    _screen.mainFrame = _templEngine.build('Menu', 'Main menu')
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
    _screen.mainFrame = _templEngine.build('Menu', name)
    _screen.titleBar[2].setValue(_screen.mainFrame.name)
    self.setDescription(_screen.mainFrame.getSelectedItem().ref.desc)
    for k, v in pairs(_screen.mainFrame) do
      if k:sub(1,2) == 'on' then
        _eventProvider.connect(k, v, self)
      end
    end
  end
  
  self.setTitle = function(value)
    _screen.titleBar[2].setValue(value)
  end
  
  self.setDescription = function(desc)
    if desc == nil then
      if _timers[1] ~= nil then
        _timers[1].stop()
      end
      _screen.statusBar[1].setValue(os.date())
      return
    end
  
    local timers_stopped = true
    for k, v in pairs(_timers) do
      timers_stopped = timers_stopped and v.isStopped()
    end
  
    if desc == 'datetime' and timers_stopped then
      _screen.statusBar[1].setValue(os.date())
      return
    elseif desc ~= 'datetime' or timers_stopped then
      _screen.statusBar[1].setValue(desc)
      if _timers[1] == nil then
        _timers[1] = Timer.new(5, self.onTimer1)
        _timers[1].start()
      else
        _timers[1].start()
      end
    end
  end

  self.checkPermission = function()
    if _user.checkPermission(permission) then
      self.showMenu(_screen.mainFrame.getSelectedItem().name)
    else
      self.askPassword()
    end
  end  

  self.askPassword = function()
    local username = User.getNames(permission)
    _screen.statusBar[1].setValue("Enter "..username..' password: ')
    _screen.statusBar[1].setAlign('left')
    _screen.statusBar[1].setMaxSize(_screen.width - 6)
    _screen.statusBar[2] = Edit.new(nil, true, 6)
    self._connectEvents(_screen.statusBar[2])
  end

  self.isNotGranted = function()
    _screen.statusBar[1].setValue('Invalid password')
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

  self.onTimer1 = function()
    self.setDescription(nil)
    return true
  end
  --end
  return self
end



