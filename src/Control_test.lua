t = {
  One = 'One',
  Two = 'Two',
  Three = 'Three',
 }
package.path = package.path..';./src/?.lua'
require('Helpers')
local props = {
  x1 = 10,
  x2 = 20,
  focused = true
}

local Line = require('Line'):create(props)
Line:setStart(10, 10)