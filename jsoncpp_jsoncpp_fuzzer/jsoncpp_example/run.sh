TRIGGER_VARIABLES=true ./jsoncpp_example
sudo /home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out -t 2000 ./jsoncpp_example
/home/vagrant/touch_of_death/pin/pin -t /home/vagrant/touch_of_death/tracer/obj-ia32/trace.so -o jsoncpp.record -- ./jsoncpp_example
