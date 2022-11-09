make test
LD_LIBRARY_PATH=/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/libpng-1.2.56/libpng-1.2.56/.libs TRIGGER_VARIABLES=true .libs/pngtest pngtest.png
LD_LIBRARY_PATH=/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/libpng-1.2.56/libpng-1.2.56/.libs:/home/vagrant/touch_of_death/critial-data-trace/oss-fuzz/projects/augeas/augeas/build/src/.libs/
/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out -t 2000 .libs/pngtest pngtest.png
LD_LIBRARY_PATH=/home/vagrant/touch_of_death/critial-data-trace/fuzzbench/benchmarks/libpng-1.2.56/libpng-1.2.56/.libs:/home/vagrant/touch_of_death/critial-data-trace/oss-fuzz/projects/augeas/augeas/build/src/.libs/ /home/vagrant/touch_of_death/pin/pin -t /home/vagrant/touch_of_death/tracer/obj-ia32/trace.so -o libpng.record -- .libs/pngtest pngtest.png


