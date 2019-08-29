-- Line class
require("Control")

Line = {}
Line.__index = Line

setmetatable(Line, {
  __index = Control,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Line:_init(props)
  Control:_init(props)
  self.class = "Line"
end
