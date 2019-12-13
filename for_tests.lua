package.cpath = package.cpath..";./src/cpm/Debug/?.so"
package.path = package.path..";./src/?.lua"

cpm = require("cpm")

print(cpm.init())
print(cpm.drawLine(65535, 65535, 65535, 65535, 255))
print(cpm.shutdown())
