package.path = package.path..';./src/?.lua'..';./src/xml2lua/?.lua'..';./src/u-test/?.lua'..';./src/utf8/?.lua'
require('debugger')()
local tfx = require('termfx')
require('User')
require('Edit')

tfx.init()
tfx.clear(tfx.color.GREEN, tfx.color.BLACK)
local pass = ''
local currUser = User.new('None')
local edit = Edit.new(nil, true, 6)
local buff = tfx.newbuffer(6, 1)
local ok, err = pcall(function()
  stopped = false
  repeat
    evt = tfx.pollevent(10)
    if evt ~= nil then
      if evt.char == 'q' then stopped = true end
      if evt.key == tfx.key.ESC then
        edit.onCancelEdit()
      end
      if evt.key == tfx.key.ENTER then
        if not currUser.checkPermission(2) then
          if not edit.isEdited() then
            edit.onBeginEdit()
          else
            edit.onEndEdit()
            if not currUser.logIn(edit.getValue()) then
              tfx.printat(1, 3,'Invalid user password!')
            elseif not currUser.checkPermission(2) then
              tfx.printat(1, 3, 'Not System user!')
              currUser.logOut()
            else
              tfx.printat(1, 3, '')
            end
          end
        end
      end
      if evt.char >= '1' or evt.char <= '0' then
        edit.onDigit(nil, evt.char)
      end
    end
    if edit.isEdited() then
      buff:clear(tfx.color.BLACK, tfx.color.GREEN)
    else
      buff:clear(tfx.color.GREEN, tfx.color.BLACK)
    end
    buff:printat(1, 1, edit.drawText())
    tfx.blit(1, 1, buff)
    tfx.printat(1, 2,'Current user is:'..currUser.getUserName())
    tfx.present()
  until stopped
end)
tfx.shutdown()
if not ok then print("Error: "..err) end

