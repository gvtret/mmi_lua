require('MmiData')

User = {}
User.new = function ()
  --start
  local self = {}
  
  local _permission = 0
  local _sha2 = require('hash')
  local _username = 'None'
  local _userdata = users.None

  self.checkPermission= function(permission)
    if _userdata.permission == nil then
      return false
    end
    if bit32.band(permission, _userdata.permission) == _userdata.permission then
      return true
    else
      return false
    end
  end
  
  self.login = function(password)
    for k, v in pairs(users) do
      if v.hash == _sha2.hash256(password) then
        _username = k
        _userdata = v
        return true
      end
    end 
    return false
  end
  
  self.logOut = function()
    _username = ''
    _userdata = nil
  end
  
  self.getUsername = function()
    return _username
  end
  
  return self
end 