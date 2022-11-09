
CC=/home/vagrant/touch_of_death/AFL/afl-clang-fast CXX=/home/vagrant/touch_of_death/AFL/afl-clang-fast++ CFLAGS="-g -O0" CXXFLAGS="-g -O0" ./configure --disable-all     --enable-option-checking=fatal      --enable-exif     --enable-mbstring     --without-pcre-jit     --disable-phpdbg     --disable-cgi     --with-pic
/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out -t 2000 -m 2222 ./sapi/cli/php --ini
/home/vagrant/touch_of_death/pin/pin -t /home/vagrant/touch_of_death/tracer/obj-ia32/trace.so -o php.record -- ./sapi/cli/php --ini
