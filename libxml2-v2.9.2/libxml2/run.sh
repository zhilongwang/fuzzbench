/home/vagrant/touch_of_death/AFL/afl-clang-fast++ -o target target.cc -Iinclude .libs/libxml2.a -g -O0 -rtlib=compiler-rt -lxml2 -lz
TRIGGER_VARIABLES=true ./target ./regressions.xml
/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out -t 2000 ./target ./regressions.xml

/home/vagrant/touch_of_death/pin/pin -t /home/vagrant/touch_of_death/tracer/obj-ia32/trace.so -o libxml.record -- ./target ./regressions.xml

