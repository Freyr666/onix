#include "../../../386/include/u.h"
#include "../../include/libc.h"
#include "./386/term.h"

void
kernel_main(void) {
	/* Initialize terminal interface */
	term_init();
	/* Newline support is left as an exercise. */
	term_strwrite("Hello, kernel World!\n");
}
