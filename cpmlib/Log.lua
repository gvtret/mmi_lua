-- Log class
require('cpmlib.Helpers')
local Log = class()

function Log:init()
  
end

function Log:print(severity, msg)
  local info = debug.getinfo(2)
  local severity_str = ''
  if severity == 1 then severity_str = '[ERROR]'
  elseif severity == 2 then severity_str = '[WARN]'
  elseif severity == 3 then severity_str = '[MSG]'
  end
  print(string.format('%s[%s]:[%d][%s][%s][%s] - %s', 
                      severity_str, info.source, 
                      info.currentline, info.what, 
                      info.namewhat, info.name, msg))
end

return Log

