#include <stdio.h>
#include <string.h>
#include <cstdint>
#include <vorbis/vorbisfile.h>
#include <stdlib.h> // pulls in declaration of malloc, free
struct vorbis_data {
  const uint8_t *current;
  const uint8_t *data;
  size_t size;
};

size_t read_func(void *ptr, size_t size1, size_t size2, void *datasource) {
  vorbis_data* vd = (vorbis_data *)(datasource);
  size_t len = size1 * size2;
  if (vd->current + len > vd->data + vd->size) {
      len = vd->data + vd->size - vd->current;
  }
  memcpy(ptr, vd->current, len);
  vd->current += len;
  return len;
}


extern "C" int LLVMFuzzerTestOneInput(const uint8_t *Data, size_t Size) {
  ov_callbacks memory_callbacks = {0};
  memory_callbacks.read_func = read_func;
  vorbis_data data_st;
  data_st.size = Size;
  data_st.current = Data;
  data_st.data = Data;
  OggVorbis_File vf;
  int result = ov_open_callbacks(&data_st, &vf, NULL, 0, memory_callbacks);
  if (result < 0) {
    return 0;
  }
  int current_section = 0;
  int eof = 0;
  char buf[4096];
  int read_result;
  while (!eof) {
    read_result = ov_read(&vf, buf, sizeof(buf), 0, 2, 1, &current_section);
    if (read_result != OV_HOLE && read_result <= 0) {
      eof = 1;
    }
  }
  ov_clear(&vf);
  return 0;
}

// Entry point for LibFuzzer.
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