/*
 * libgui.hpp
 */

/*
 * drawLine(int x1, int y1, int x2, int y2, char attr) – рисование линии. x1, y1 – координаты начала линии. x2, y2 – координаты конца линии attr – старшие 4 бита – градация форэграунда, младшие 4 бита - бэкграунда.
 * drawIcon(int x, int y, int w int h, byte *image, char attr) – рисование иконки. x, y – координаты верхнего левого угла, w - ширина, h - высота, image – массив байтов, содержащий построчное представление иконки. Каждый бит имеет следующие значения: 0 – цвет бэкграунда, 1 – цвет форэграунда, attr – старшие 4 бита – градация фореграунда, младшие 4 бита - бэкграунда.
 * drawText(int x, int y, char *str, int size, char attr) - рисование строки текста. x, y – координаты верхнего левого угла str – указатель на строку символов, size – длина строки, attr – старшие 4 бита – градация форэграунда, младшие 4 бита - бэкграунда.
 * drawScrollBar(int x, int y, int max_pos, int curr_pos, bool blink, char attr) – рисование полосы прокрутки. x, y – координаты верхнего левого угла, max_pos – максимальное значение в строках (высоты символов), curr_pos – текущая позиция, blink – мигание позиционера, attr – старшие 4 бита – градация фореграунда, младшие 4 бита - бэкграунда.
 * clearRegion(int x1, int y1, int x2, int y2, char attr) – очистка области. X1, y1 – координаты верхнего левого угла, x2, y2 – координаты нижнего правого угла, attr - старшие 4 бита – градация фореграунда, младшие 4 бита – бэкграунда. В случае ошибки возвращается «-1». В случае успеха – «1».
 * getScancode() – возвращает сканкод кнопки. Старший бит – признак нажатия(1)/отпускания(0). В случае отсутствия изменений с предыдущего запроса – возвращает «-1».
 * setLeds(int mask) – устанавливает какие светодиоды должны гореть, а какие нет. mask – битовая маска для светодиодов (0 – выключен, 1 – включен).
 * setCharset(int w, int h, char *charset) – загрузка таблицы символов в MMI. h – высота символа, w – ширина символа, charset – массив структур, каждый элемент состоит из кода символа + буфер битового представления символа.
 */
#ifndef LIBGUI_HPP
#define LIBGUI_HPP

#include "liblua/lua.hpp"
#include <cstdint>

/// Function ID's
static const char ID_DRAWLINE = 0x01;
static const char ID_DRAWICON = 0x02;
static const char ID_DRAWTEXT = 0x03;
static const char ID_DRAWSCROLLBAR = 0x04;
static const char ID_CLEARREGION = 0x05;
static const char ID_GETSCANCODE = 0x06;
static const char ID_SETLEDS = 0x07;
static const char ID_SETCHARSET = 0x08;

LUAMOD_API int luaopen_libgui(lua_State *L);
LUAMOD_API int drawLine(lua_State *L);
LUAMOD_API int drawIcon(lua_State *L);
LUAMOD_API int drawText(lua_State *L);
LUAMOD_API int drawScrollBar(lua_State *L);
LUAMOD_API int clearRegion(lua_State *L);
LUAMOD_API int getScancode(lua_State *L);
LUAMOD_API int setLeds(lua_State *L);
LUAMOD_API int setCharset(lua_State *L);
LUAMOD_API int init(lua_State *L);
LUAMOD_API int shutdown(lua_State *L);

static const luaL_Reg libgui_funcs[] = {
  {"drawLine", drawLine},
  {"drawIcon", drawIcon},
  {"drawText", drawText},
  {"drawScrollBar", drawScrollBar},
  {"clearRegion", clearRegion},
  {"getScancode", getScancode},
  {"setLeds", setLeds},
  {"setCharset", setCharset},
  {"init", init},
  {"shutdown", shutdown},
  {NULL, NULL},
};
typedef struct {
	uint16_t x;
	uint16_t y;
} point;

int fd; //Port descriptor
char txBuff[256]; // Transmit Buffer
int msgLen;

#endif /* LIBGUI_HPP */
