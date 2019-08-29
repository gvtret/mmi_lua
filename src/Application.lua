require ('utils')
require ('Icon')
require ('Timer')
require ('Text')
require ('List')
require ('User')

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
    _mid = _screen.titleBar.logoIcon.drawText()
    _mid = _mid.._screen.titleBar.title.drawText()
    _mid = _mid.._screen.titleBar.ctxIcon.drawText()
    _end = _utf8.char(tblSigns.bold.VERL)
    _s = _start.._mid.._end
    _gui.printat(1, 2, _s)
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
    s = string.rep('-',_screen.width)
    self.setDescription('datetime')
  
    _start = _utf8.char(tblSigns.bold.VERL)
    _mid = _screen.statusBar.drawText()
    _end = _utf8.char(tblSigns.bold.VERL)
    _s = _start.._mid.._end
    _gui.printat(1, 9, _s)
    _start = _utf8.char(tblSigns.bold.LBMC)
    _mid = _utf8.char(tblSigns.bold.HORL):rep(64)
    _end = _utf8.char(tblSigns.bold.RBMC)
    _s = _start.._mid.._end
    _gui.printat(1, 10, _s)
  end
  
  --public members
  self.init = function ()
    for k, v in pairs(self) do
      if k:sub(1,2) == 'on' then
        _eventProvider.connect(k, v, self)
      end
    end
    _gui.init()
    _gui.clear(_gui.color.GREEN, _gui.color.BLACK)  
    _screen.titleBar.logoIcon = Icon.new(nil, 'logo')
    _screen.titleBar.ctxIcon = Icon.new(nil, 'menu')
    _screen.titleBar.title = Text.new(nil, 'Main Menu')
    _screen.titleBar.title.setAlign('center')
    _screen.titleBar.title.setMaxSize(_screen.width - (_screen.titleBar.logoIcon.getSize() + _screen.titleBar.ctxIcon.getSize()))
    _screen.mainFrame = _templEngine.build('Menu', 'Main menu')
    _screen.titleBar.ctxIcon.setType(_screen.mainFrame.getItem(1).ref_type)
    _screen.statusBar = Text.new(nil,'')
    self.setDescription(_screen.mainFrame.getItem(_screen.mainFrame.getSelectedIndex()).ref.desc)
    _screen.statusBar.setAlign('center')
    _screen.statusBar.setMaxSize(_screen.width)
    for k, v in pairs(_screen.mainFrame) do
      if k:sub(1,2) == 'on' then
        _eventProvider.connect(k, v, self)
      end
    end
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
    _gui.shutdown()
  end

  self.setCtxIconType = function(icon_type)
    _screen.titleBar.ctxIcon.setType(icon_type)
  end
  
  self.showMenu = function(name)
    _screen.mainFrame = _templEngine.build('Menu', name)
    _screen.titleBar.title.setValue(_screen.mainFrame.name)
    self.setDescription(_screen.mainFrame.getItem(_screen.mainFrame.getSelectedIndex()).ref.desc)
    for k, v in pairs(_screen.mainFrame) do
      if k:sub(1,2) == 'on' then
        _eventProvider.connect(k, v, self)
      end
    end
  end
  
  self.setTitle = function(value)
    _screen.titleBar.title.setValue(value)
  end
  
  self.setDescription = function(desc)
    if desc == nil then
      if _timers[1] ~= nil then
        _timers[1].stop()
      end
      _screen.statusBar.setValue(os.date())
      return
    end
  
    local timers_stopped = true
    for k, v in pairs(_timers) do
      timers_stopped = timers_stopped and v.isStopped()
    end
  
    if desc == 'datetime' and timers_stopped then
      _screen.statusBar.setValue(os.date())
      return
    elseif desc ~= 'datetime' or timers_stopped then
      _screen.statusBar.setValue(desc)
      if _timers[1] == nil then
        _timers[1] = Timer.new(5, self.onTimer1)
        _timers[1].start()
      else
        _timers[1].start()
      end
    end
  end

  self.checkPermission = function(permission, ok_callback, nok_callback)
    if _user.checkPermission(permission) then
      if ok_callback ~= nil then ok_callback() end
    else
      if nok_callback ~= nil then nok_callback() end
    end
  end  
  
  self.onTimer1 = function()
    self.setDescription(nil)
    return true
  end
  --end
  return self
end



