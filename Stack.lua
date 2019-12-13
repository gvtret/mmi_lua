---@class Stack
require("Control")

Stack = {}
Stack.__index = Stack

setmetatable(Stack, {
  __index = Control,
  __call = function (cls, ...)
      local self = setmetatable({}, cls)
      self:_init(...)
      return self
    end,
})

function Stack:_init(props)
  Control:_init(props)
  self.class = "Stack"
end