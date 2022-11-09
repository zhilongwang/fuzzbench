/home/vagrant/touch_of_death/AFL/afl-fuzz -D 4937 -i in -o out -- ./curl http://zhilongwang.org

../../../../../../../pin/pin -t ../../../../../../../tracer/obj-ia32/trace.so -o curl.record -- ./curl http://zhilongwang.org
