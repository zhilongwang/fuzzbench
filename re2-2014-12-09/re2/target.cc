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

#include <string>
#include "re2/re2.h"

extern "C" int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
  if (size < 3 || size > 64) return 0;
  uint16_t f = (data[0] << 16) + data[1];
  RE2::Options opt;
  opt.set_log_errors(false);
  if (f & 1) opt.set_encoding(RE2::Options::EncodingLatin1);
  opt.set_posix_syntax(f & 2);
  opt.set_longest_match(f & 4);
  opt.set_literal(f & 8);
  opt.set_never_nl(f & 16);
  opt.set_dot_nl(f & 32);
  opt.set_never_capture(f & 64);
  opt.set_case_sensitive(f & 128);
  opt.set_perl_classes(f & 256);
  opt.set_word_boundary(f & 512);
  opt.set_one_line(f & 1024);
  const char *b = reinterpret_cast<const char*>(data) + 2;
  const char *e = reinterpret_cast<const char*>(data) + size;
  std::string s1(b, e);
  RE2 re(s1, opt);
  if (re.ok())
    RE2::FullMatch(s1, re);
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


