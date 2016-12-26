#include "../../../../386/include/u.h"
#include "../../../include/libc.h"
#include "./term.h"

static ushort* const VGA_BUFFER = (ushort*)0xB8000;

/* fgc chars on bgc bg */
static uchar VGA_COLOR(enum vga_color fgc, enum vga_color bgc)	
{
	return (uchar)(fgc) | (uchar)(bgc)<<4;
}

static ushort VGA_ENTRY(uchar chr, uchar clr)
{
	return (ushort)(chr) | (ushort)(clr)<<8;
}

static const size_t VGA_WIDTH = 80;
static const size_t VGA_HEIGHT = 25;

typedef struct _term {
	ushort* buffer;
	uchar   color;
	size_t  row;
	size_t  col;
} Term;

/* state */
static Term state; 

void
term_init(void) {

	size_t x, y;

	state.col = 0;
	state.row = 0;
	state.color  = VGA_COLOR(VGA_COLOR_LIGHT_GREY, VGA_COLOR_BLACK);
	state.buffer = (ushort*) VGA_BUFFER;

	for (y = 0; y < VGA_HEIGHT; y++) {

		for (x = 0; x < VGA_WIDTH; x++) {

			const size_t index = y * VGA_WIDTH + x;
			state.buffer[index] = VGA_ENTRY(' ',state.color);
		}
	}
}

void
term_set_color(uchar color) {

	state.color = color;
}

static void
term_putchar_at(char c, uchar color,
		 size_t x, size_t y) {
	const size_t index = y * VGA_WIDTH + x;
	state.buffer[index] = VGA_ENTRY(c, color);
}

void
term_putchar(char c) {
	
	term_putchar_at(c, state.color,
			state.col, state.row);
	if (++state.col == VGA_WIDTH) {
		state.col = 0;
		if (++state.row == VGA_HEIGHT)
			state.row = 0;
	}
}

void
term_write(const char* data, size_t size) {

	size_t i;
	
	for (i = 0; i < size; i++)
		term_putchar(data[i]);
}
 
void
term_strwrite(const char* data) {

	term_write(data, strlen(data));
}
