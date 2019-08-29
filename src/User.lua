require('MmiData')

User = {}
User.new = function (username)
  --start
  local self = {}
  
  local _permission = 0
  local _sha2 = require('hash')
  local _username = 'None'
  if username ~= nil and username ~= '' then
    _username = username
  end
  
  local _userdata = users[username]

  self.checkPermission= function(permission)
    if _userdata.id == nil then
      return false
    end
    if bit32.band(permission, _userdata.id) == _userdata.id then
      return true
    else
      return false
    end
  end
  
  self.logIn = function(password)
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
    _username = 'None'
    _userdata = users[_username]
  end
  
  self.getUserName = function(permission)
    if permission == nil then return _username end
  end
  
  return self
end 