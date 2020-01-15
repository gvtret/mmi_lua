require('MmiData')
local usersDb = _G.Db.users
local hash256 = require('hash').hash256
local User = class()

function User.getNames(permissions)
  local names = {}
  for k, v in pairs(usersDb) do
    if bit32.band(permissions, v.id) == v.id or permissions == 0 then
      table.insert(names, k)
    end
  end
  return unpack(names)
end

function User:init(username)
  self._permission = 0
  self._username = 'None' or username
  self._userdata = usersDb[self._username]
end

function User:checkPermission(permission)
  if self._userdata.id == nil then
    return false
  end
  if bit32.band(permission, self._userdata.id) == self._userdata.id then
    return true
  else
    return false
  end
end

function User:logIn(password)
  for k, v in pairs(usersDb) do
    if v.hash == hash256(password) then
      self._username = k
      self._userdata = v
      return true
    end
  end
  return false
end

function User:logOut()
    self._username = 'None'
    self._userdata = usersDb[self._username]
end

function User:getUserName()
    return self._username
end
--[[require('MmiData')
local User = {}
User.getNames = function(permissions)
    local names = {}
    for k, v in pairs(users) do
        if bit32.band(permissions, v.id) == v.id then
            table.insert(names,k)
        end
    end
    return unpack(names)
end

User.new = function(username)
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
--]]
return User