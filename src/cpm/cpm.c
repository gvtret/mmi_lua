/*
 * cpm.cpp
 */

#define LUA_COMPAT_MODULE

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <termios.h>
#include <stdint.h>

#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

#include "cpm.h"

int luaopen_cpm(lua_State *L) {
	luaL_register(L, "cpm", cpm_funcs);
	return 1;
}

int init(lua_State *L) {
	fd = open(PORT, O_RDWR | O_NOCTTY | O_NDELAY);
	if (fd == -1)
		perror("Unable to open port.");
	tcflush(fd, TCIOFLUSH);
	lua_pushinteger(L, fd);
	return 1;
}

int shutdown(lua_State *L) {
	close(fd);
	return 0;
}

int drawLine(lua_State *L) {

	point p1;
	point p2;
	p1.x = luaL_checkint(L, 1);
	p1.y = luaL_checkint(L, 2);
	p2.x = luaL_checkint(L, 3);
	p2.y = luaL_checkint(L, 4);
	uint8_t attr = luaL_checkint(L, 5);
	printf("(%d, %d)-(%d, %d). attr: %x\n", p1.x, p1.y, p2.x, p2.y, attr);
	memset(&txBuff, 0x00, sizeof(txBuff));
	msgLen = 0;
	memcpy(&txBuff[0], &ID_DRAWLINE, sizeof(ID_DRAWLINE));
	msgLen += sizeof(ID_DRAWLINE);
	memcpy(&txBuff[msgLen], &p1, sizeof(p1));
	msgLen += sizeof(p1);
	memcpy(&txBuff[msgLen], &p2, sizeof(p2));
	msgLen += sizeof(p2);
	memcpy(&txBuff[msgLen], &attr, sizeof(attr));
	msgLen += sizeof(attr);
	printf("Msg size: %d\n", msgLen);
	printf("Msg:");
	for (int i = 0; i < msgLen; i++)
		printf(" 0x%2X", txBuff[i]);
	printf("\n");

	int bytes_written = write(fd, &txBuff, sizeof(msgLen));
	tcflush(fd, TCOFLUSH);
	lua_pushinteger(L, bytes_written);
	return 1;
}

int drawIcon(lua_State *L) {
	return 0;
}

int drawText(lua_State *L) {
	return 0;
}

int drawScrollBar(lua_State *L) {
	return 0;
}

int clearRegion(lua_State *L) {
	return 0;
}

int getScancode(lua_State *L) {
	return 0;
}

int setLeds(lua_State *L) {
	return 0;
}

int setCharset(lua_State *L) {
	return 0;
}




