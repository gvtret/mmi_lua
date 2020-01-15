-- Queue class
require('cpmlib.Helpers')
local Queue = class()
local loggger = require('cpmlib.Log')()

function Queue:init()
  self._content = {}
end

function Queue:push(value)
  table.insert(self._content, value)
end

function Queue:pop()
  if #self._content == 0 then
    loggger:print(2, 'queue is empty. Return nil.')
    return
  end
  return table.remove(self._content, 1)
end

function Queue:top()
  if #self._content == 0 then
    loggger:print(2, 'queue is empty. Return nil.')
    return
  end
  return self._content[1]
end

function Queue:isEmpty()
  return #self._content == 0
end

return Queue

