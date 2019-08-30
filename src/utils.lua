local tfx = require("termfx")

tblSigns = {
  regular = {
    HORL=0x2500, VERL=0x2502, LTPC=0x250C, RTPC=0x2510,
    LBMC=0x2514, RBMC=0x2518, LCRS=0x251C, RCRS=0x2524,
    TCRS=0x252C, BCRS=0x2534, CCRS=0x253C
    },
  bold = {
    HORL=0x2501, VERL=0x2503, LTPC=0x250F, RTPC=0x2513,
    LBMC=0x2517, RBMC=0x251B, LCRS=0x2523, RCRS=0x252B,
    TCRS=0x2533, BCRS=0x253B, CCRS=0x254B
    },
  }
  

color = {
  GREEN = tfx.color.GREEN,
  BLACK = tfx.color.BLACK,
}

timer_name = {
  showDesc = 1,
  cancelled = 2,
  invalid = 3,
}
