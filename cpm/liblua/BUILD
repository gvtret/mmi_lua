cc_library(
  name = "liblua",
  srcs = glob(["*.c", "*.h"],
              exclude = ["lua.c, luac.c"]),
  hdrs = ["lua.h", "luaconf.h", "lualib.h",
          "lauxlib.h", "lua.hpp"],
  visibility = ["//visibility:public"],
  linkstatic = True,
)
