local test = require('u-test.u-test')
local stack = cpmlib.Stack()

test.Stack.push_1 = function()
  stack:push(1)
  test.equal(stack:top(), 1)
end

test.Stack.push_2 = function()
  stack:push(2)
  test.equal(stack:top(), 2)
end

test.Stack.push_3 = function()
  stack:push(3)
  test.equal(stack:top(), 3)
end

test.Stack.pop_3 = function ()
  test.equal(stack:pop(), 3)
  test.equal(stack:top(), 2)
end

test.Stack.pop_2 = function ()
  test.equal(stack:pop(), 2)
  test.equal(stack:top(), 1)
end

test.Stack.pop_1 = function ()
  test.equal(stack:pop(), 1)
  test.assert(stack:isEmpty())
end
