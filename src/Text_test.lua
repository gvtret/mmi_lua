package.path = package.path..';./src/?.lua'..';./src/xml2lua/?.lua'..';./src/u-test/?.lua'
require('Text')
local test = require ('u-test.u-test')
local text = Text()

test.Text.start_up = function ()
    text.value = 'some text'
end

test.Text.test_size = function ()
    text.align = 'left'
    test.equal(#text:draw()[1], text.max_size)
    text.align = 'center'
    test.equal(#text:draw()[1], text.max_size)
    text.align = 'right'
    test.equal(#text:draw()[1], text.max_size)
end

test.Text.test_match = function()
    text.align = 'left'
    test.equal(text:draw()[1], 'some text                                           ')
    text.align = 'center'
    test.equal(text:draw()[1], '                     some text                      ')
    text.align = 'right'
    test.equal(text:draw()[1], '                                           some text')
end