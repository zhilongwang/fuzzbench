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
#include <string.h>
#include "lcms2.h"
#include <malloc.h> 
#include <stdlib.h>
// #include <cstdlib>
/**
 * Main procedure for standalone fuzzing engine.
 *
 * Reads filenames from the argument array. For each filename, read the file
 * into memory and then call the fuzzing interface with the data.
 */
extern "C" int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
  cmsHPROFILE srcProfile = cmsOpenProfileFromMem(data, size);
  if (!srcProfile) return 0;

  cmsHPROFILE dstProfile = cmsCreate_sRGBProfile();
  if (!dstProfile) {
    cmsCloseProfile(srcProfile);
    return 0;
  }

  cmsColorSpaceSignature srcCS = cmsGetColorSpace(srcProfile);
  cmsUInt32Number nSrcComponents = cmsChannelsOf(srcCS);
  cmsUInt32Number srcFormat;
  if (srcCS == cmsSigLabData) {
    srcFormat =
        COLORSPACE_SH(PT_Lab) | CHANNELS_SH(nSrcComponents) | BYTES_SH(0);
  } else {
    srcFormat =
        COLORSPACE_SH(PT_ANY) | CHANNELS_SH(nSrcComponents) | BYTES_SH(1);
  }

  cmsUInt32Number intent = 0;
  cmsUInt32Number flags = 0;
  cmsHTRANSFORM hTransform = cmsCreateTransform(
      srcProfile, srcFormat, dstProfile, TYPE_BGR_8, intent, flags);
  cmsCloseProfile(srcProfile);
  cmsCloseProfile(dstProfile);
  if (!hTransform) return 0;

  uint8_t output[4];
  if (T_BYTES(srcFormat) == 0) {  // 0 means double
    double input[nSrcComponents];
    for (uint32_t i = 0; i < nSrcComponents; i++) input[i] = 0.5f;
    cmsDoTransform(hTransform, input, output, 1);
  } else {
    uint8_t input[nSrcComponents];
    for (uint32_t i = 0; i < nSrcComponents; i++) input[i] = 128;
    cmsDoTransform(hTransform, input, output, 1);
  }
  cmsDeleteTransform(hTransform);

  return 0;
}

int main(int argc, char **argv)
{
  int ii;
  FILE *infile;
  uint8_t *buffer = NULL;
  size_t buffer_len;
  /* Try and open the file. */
  printf("input:%s\n", argv[1]);
  infile = fopen(argv[1], "rb");
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
}

//   for(ii = 1; ii < argc; ii++) {
//     printf("[%s] ", argv[ii]);

//     /* Try and open the file. */
//     infile = fopen(argv[ii], "rb");
//     if(infile) {
//       printf("Opened.. ");

//       /* Get the length of the file. */
//       fseek(infile, 0L, SEEK_END);
//       buffer_len = ftell(infile);

//       /* Reset the file indicator to the beginning of the file. */
//       fseek(infile, 0L, SEEK_SET);

//       /* Allocate a buffer for the file contents. */
//       buffer = (uint8_t *)calloc(buffer_len, sizeof(uint8_t));
//       if(buffer) {
//         /* Read all the text from the file into the buffer. */
//         fread(buffer, sizeof(uint8_t), buffer_len, infile);
//         printf("Read %zu bytes, fuzzing.. ", buffer_len);

//         /* Call the fuzzer with the data. */
//         LLVMFuzzerTestOneInput(buffer, buffer_len);

//         printf("complete !!");

//         /* Free the buffer as it's no longer needed. */
//         free(buffer);
//         buffer = NULL;
//       }
//       else
//       {
//         fprintf(stderr,
//                 "[%s] Failed to allocate %zu bytes \n",
//                 argv[ii],
//                 buffer_len);
//       }

//       /* Close the file as it's no longer needed. */
//       fclose(infile);
//       infile = NULL;
//     }
//     else
//     {
//       /* Failed to open the file. Maybe wrong name or wrong permissions? */
//       fprintf(stderr, "[%s] Open failed. \n", argv[ii]);
//     }

//     printf("\n");
//   }
// }
