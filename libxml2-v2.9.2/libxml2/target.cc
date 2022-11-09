// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <vector>
#include "include/libxml/xmlversion.h"
#include "include/libxml/parser.h"
#include "include/libxml/HTMLparser.h"
#include "include/libxml/tree.h"

void ignore (void * ctx, const char * msg, ...) {}

extern "C" int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
  xmlSetGenericErrorFunc(NULL, &ignore);
  if (auto doc = xmlReadMemory(reinterpret_cast<const char *>(data), size,
                               "noname.xml", NULL, 0))
    xmlFreeDoc(doc);
  return 0;
}
int main(int argc, char **argv)
{
  int ii;
  FILE *infile;
  uint8_t *buffer = NULL;
  size_t buffer_len;

  for(ii = 1; ii < argc; ii++) {
    printf("[%s] ", argv[ii]);

    /* Try and open the file. */
    infile = fopen(argv[ii], "rb");
    if(infile) {
      printf("Opened.. ");

      /* Get the length of the file. */
      fseek(infile, 0L, SEEK_END);
      buffer_len = ftell(infile);

      /* Reset the file indicator to the beginning of the file. */
      fseek(infile, 0L, SEEK_SET);

      /* Allocate a buffer for the file contents. */
      buffer = (uint8_t *)calloc(buffer_len, sizeof(uint8_t));
      if(buffer) {
        /* Read all the text from the file into the buffer. */
        fread(buffer, sizeof(uint8_t), buffer_len, infile);
        printf("Read %zu bytes, fuzzing.. ", buffer_len);

        /* Call the fuzzer with the data. */
        LLVMFuzzerTestOneInput(buffer, buffer_len);

        printf("complete !!");

        /* Free the buffer as it's no longer needed. */
        free(buffer);
        buffer = NULL;
      }
      else
      {
        fprintf(stderr,
                "[%s] Failed to allocate %zu bytes \n",
                argv[ii],
                buffer_len);
      }

      /* Close the file as it's no longer needed. */
      fclose(infile);
      infile = NULL;
    }
    else
    {
      /* Failed to open the file. Maybe wrong name or wrong permissions? */
      fprintf(stderr, "[%s] Open failed. \n", argv[ii]);
    }

    printf("\n");
  }
}