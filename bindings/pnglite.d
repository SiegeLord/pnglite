/*  pnglite.d - D binding for the pnglite library
    Copyright (c) 2012 Pavel Sountsov

    This software is provided 'as-is', without any express or implied
    warranty. In no event will the authors be held liable for any damages
    arising from the use of this software.

    Permission is granted to anyone to use this software for any purpose,
    including commercial applications, and to alter it and redistribute it
    freely, subject to the following restrictions:

    1. The origin of this software must not be misrepresented; you must not
       claim that you wrote the original software. If you use this software
       in a product, an acknowledgment in the product documentation would be
       appreciated but is not required.  

    2. Altered source versions must be plainly marked as such, and must not be
       misrepresented as being the original software.

    3. This notice may not be removed or altered from any source
       distribution.
 */

module pnglite;

extern(C):

/*
    Enumerations for pnglite.
    Negative numbers are error codes and 0 and up are okay responses.
*/

enum
{
	PNG_DONE                = 1,
	PNG_NO_ERROR            = 0,
	PNG_FILE_ERROR          = -1,
	PNG_HEADER_ERROR        = -2,
	PNG_IO_ERROR            = -3,
	PNG_EOF_ERROR           = -4,
	PNG_CRC_ERROR           = -5,
	PNG_MEMORY_ERROR        = -6,
	PNG_ZLIB_ERROR          = -7,
	PNG_UNKNOWN_FILTER      = -8,
	PNG_NOT_SUPPORTED       = -9,
	PNG_WRONG_ARGUMENTS     = -10
}

/*
    The five different kinds of color storage in PNG files.
*/

enum
{
	PNG_GREYSCALE           = 0,
	PNG_TRUECOLOR           = 2,
	PNG_INDEXED             = 3,
	PNG_GREYSCALE_ALPHA     = 4,
	PNG_TRUECOLOR_ALPHA     = 6
}

/*
    Typedefs for callbacks.
*/

alias uint function(void* input, size_t size, size_t numel, void* user_pointer) png_write_callback_t;
alias uint function(void* output, size_t size, size_t numel, void* user_pointer) png_read_callback_t;
alias void function(void* p) png_free_t;
alias void* function(size_t s) png_alloc_t;

struct png_t
{
	void*                  zs;                /* pointer to z_stream */
	png_read_callback_t    read_fun;
	png_write_callback_t   write_fun;
	void*                  user_pointer;

	ubyte*                 png_data;
	uint                   png_datalen;

	uint                   width;
	uint                   height;
	ubyte                  depth;
	ubyte                  color_type;
	ubyte                  compression_method;
	ubyte                  filter_method;
	ubyte                  interlace_method;
	ubyte                  bpp;
}

int png_init(png_alloc_t pngalloc, png_free_t pngfree);
int png_open_file(png_t *png, in char* filename);

int png_open_file_read(png_t *png, in char* filename);
int png_open_file_write(png_t *png, in char* filename);

int png_open(png_t* png, png_read_callback_t read_fun, void* user_pointer);

int png_open_read(png_t* png, png_read_callback_t read_fun, void* user_pointer);
int png_open_write(png_t* png, png_write_callback_t write_fun, void* user_pointer);

void png_print_info(png_t* png);

char* png_error_string(int error);

int png_get_data(png_t* png, ubyte* data);

int png_set_data(png_t* png, uint width, uint height, ubyte depth, int color, ubyte* data);

int png_close_file(png_t* png);
