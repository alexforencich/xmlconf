/************************************************************************/
/* XMLCONF                                                              */
/*                                                                      */
/* Extensibe XML based configuration generator                          */
/*                                                                      */
/* xmlconf.c                                                            */
/*                                                                      */
/* Alex Forencich <alex@alexforencich.com>                              */
/*                                                                      */
/* Copyright (c) 2010 Alex Forencich                                    */
/*                                                                      */
/* Permission is hereby granted, free of charge, to any person          */
/* obtaining a copy of this software and associated documentation       */
/* files(the "Software"), to deal in the Software without restriction,  */
/* including without limitation the rights to use, copy, modify, merge, */
/* publish, distribute, sublicense, and/or sell copies of the Software, */
/* and to permit persons to whom the Software is furnished to do so,    */
/* subject to the following conditions:                                 */
/*                                                                      */
/* The above copyright notice and this permission notice shall be       */
/* included in all copies or substantial portions of the Software.      */
/*                                                                      */
/* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,      */
/* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF   */
/* MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                */
/* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS  */
/* BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN   */
/* ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN    */
/* CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE     */
/* SOFTWARE.                                                            */
/*                                                                      */
/************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <libgen.h>
#include <getopt.h>
#include <string.h>
#include <inttypes.h>

#include <expat.h>
#include <zlib.h>

void usage(FILE *stream, char *program);

int main (int argc, char **argv)
{
    int opt;
    
    struct option long_options[] = {
        //{"id", required_argument, 0, 'i'},
        //{"cid", required_argument, 0, 'c'},
        //{"ver", required_argument, 0, 'v'},
        //{"sn", required_argument, 0, 's'},
        //{"ed", required_argument, 0, 'e'},
        //{"dt", required_argument, 0, 'd'},
        //{"read", required_argument, 0, 'r'},
        //{"file", required_argument, 0, 'f'},
        //{"output", required_argument, 0, 'o'},
        //{"type", required_argument, 0, 't'},
        {"version", no_argument, 0, 'v'},
        {0, 0, 0, 0}
    };
    
    printf("XMLCONF\n");
    
    while ((opt = getopt_long(argc, argv, "v", long_options, NULL)) != -1)
    {
        switch (opt)
        {
            case 'v':
                printf("xmlconf version xxx\n");
                exit(0);
                break;
        }
    }
    
    if (argc == optind)
    {
        usage(stderr, basename(argv[0]));
        return 0;
    }
    
    printf("%s\n", argv[optind]);
    
    return 0;
}

void usage(FILE *stream, char *program)
{
    fprintf(stream, "Usage: %s [<options>] [<filename>]\n", program);
    fprintf(stream, "Options:\n");
    //fprintf(stream, " -i, --id=<id>                ID number, in hex (default: 0000)\n");
    //fprintf(stream, " -c, --cid=<cid>              Collection/job ID, in hex (default: 00000000)\n");
    //fprintf(stream, " -v, --ver=<maj>.<min>.<rev>  Version (default: 1.0.0)\n");
    //fprintf(stream, " -s, --sn=<sn>                Serial number, in hex (default: 0000000000000000)\n");
    //fprintf(stream, " -e, --ed=<ed>                Extra data, in hex (default: none)\n");
    //fprintf(stream, " -d, --dt=<desc>              Description text, plain (default: HW)\n");
    //fprintf(stream, " -r, --read=<name>            Read bin/hex/ihex ID file\n");
    //fprintf(stream, " -f, --file=<name>            ID file\n");
    //fprintf(stream, " -o, --output=<name>          Output file\n");
    //fprintf(stream, " -t, --type=<type>            Output type (bin, hex, ihex)\n");
    fprintf(stream, " -v, --version                Print version information and exit\n");
}


