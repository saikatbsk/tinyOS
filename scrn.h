#ifndef _SCRN_H
#define _SCRN_H

#define COLS 80
#define ROWS 24

extern void cls();
extern void putch(unsigned char c);
extern void puts(unsigned char * str);
extern void settextcolor(unsigned char forecolor, unsigned char backcolor);
extern void init_video();

#endif
