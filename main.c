#include <system.h>
#include <scrn.h>

unsigned char * memcpy(unsigned char * dest,
    const unsigned char * src, int count) {
  int i;
  for(i = 0 ; i < count ; ++i)
    dest[i] = src[i];
  return dest;
}

extern unsigned char * memset(unsigned char * dest,
    unsigned char val, int count) {
  int i;
  for(i = 0 ; i < count ; ++i)
    dest[i]=val;
  return dest;
}

extern unsigned short * memsetw(unsigned short * dest,
    unsigned short val, int count) {
  int i;
  for(i = 0 ; i < count ; ++i)
    dest[i]=val;
  return dest;
}

int strlen(const char * str) {
  int i;
  for(i = 0 ; ; ++i)
    if(str[i] == '\0')
      return i;
}

unsigned char inportb(unsigned short _port) {
  unsigned char rv;
  __asm__ __volatile__ ("inb %1, %0" : "=a" (rv) : "dN" (_port));
  return rv;
}

void outportb (unsigned short _port, unsigned char _data) {
  __asm__ __volatile__ ("outb %1, %0" : : "dN" (_port), "a" (_data));
}

void cmain(unsigned long magic, unsigned long addr) {
  init_video();

  //settextcolor(15, 0);
  //puts((unsigned char*)"Hello World !!\n");

  int row, col;
  int color = 0;

  for(row = 0 ; row < ROWS - 1 ; row++)
    for(col = 0 ; col < COLS ; col++) {
      settextcolor(color, 0);
      putch('*');

      if(color < 15)
        color++;
      else
        color = 0;
    }

  for( ; ; );
}
