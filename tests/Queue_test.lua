local test = require('u-test.u-test')
local queue = cpmlib.Queue()

test.Queue.push_1 = function()
  queue:push(1)
  test.equal(queue:top(), 1)
end

test.Queue.push_2 = function()
  queue:push(2)
  test.equal(queue:top(), 1)
end

test.Queue.push_3 = function()
  queue:push(3)
  test.equal(queue:top(), 1)
end

test.Queue.pop_1 = function ()
  test.equal(queue:pop(), 1)
  test.equal(queue:top(), 2)
end

test.Queue.pop_2 = function ()
  test.equal(queue:pop(), 2)
  test.equal(queue:top(), 3)
end

test.Queue.pop_3 = function ()
  test.equal(queue:pop(), 3)
  test.assert(queue:isEmpty())
end
