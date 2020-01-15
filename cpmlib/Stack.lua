-- Stack class
require('cpmlib.Helpers')
local Stack = class()
local logger = require('cpmlib.Log')()

function Stack:init()
  self._content = {}
end

function Stack:push(value)
  table.insert(self._content, value)
end

function Stack:pop()
  if #self._content == 0 then
    logger:print(2, 'stack is empty. Return nil')
    return
  end
  return table.remove(self._content, #self._content)
end

function Stack:top()
  if #self._content == 0 then
    logger:print(2, 'stack is empty. Return nil.')
    return
  end
  return self._content[#self._content]
end

function Stack:isEmpty()
  return #self._content == 0
end

return Stack
