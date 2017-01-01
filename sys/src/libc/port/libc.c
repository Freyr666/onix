#include "../../../../386/include/u.h"
#include "../../../include/libc.h"

size_t
strlen(const char* str) {
	size_t len;

	len = 0;
	
	while (str[len++]);

	return len;
}
