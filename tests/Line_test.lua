local test = require('u-test.u-test')
local line = cpmlib.Line({}, cpmlib.Log())

test.Line.test_setStart = function()
    line:setStart(5, 10)
    local x, y = line:getStart()
    test.equal(x, 5)
    test.equal(y, 10)
end

test.Line.test_setEnd = function()
    line:setEnd(50, 100)
    local x, y = line:getEnd()
    test.equal(x, 50)
    test.equal(y, 100)
end


