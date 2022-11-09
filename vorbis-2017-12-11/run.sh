/home/vagrant/touch_of_death/AFL/afl-clang-fast++ -g -O0   -std=c++11 decode_fuzzer.cc -o decode_fuzzer -lvorbisfile -lvorbis -logg
/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out -t 2000 ./decode_fuzzer seeds/sound.ogg


/home/vagrant/touch_of_death/pin/pin -t /home/vagrant/touch_of_death/tracer/obj-ia32/trace.so -o vorbis.record -- ./decode_fuzzer seeds/sound.ogg

