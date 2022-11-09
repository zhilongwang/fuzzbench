 /home/vagrant/touch_of_death/AFL/afl-clang-fast jpeg_sample.c -o jpeg_sample -I../libjpeg-turbo ../libjpeg-turbo/.libs/libjpeg.a
 /home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out -t 2000 -m 3000000 ./jpeg_sample
 /home/vagrant/touch_of_death/pin/pin -t /home/vagrant/touch_of_death/tracer/obj-ia32/trace.so -o libjpeg.record -- ./jpeg_sample
