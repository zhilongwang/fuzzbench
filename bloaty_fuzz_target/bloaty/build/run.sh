TRIGGER_VARIABLES=true ./bloaty ./bloaty
/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out -m 1000 ./bloaty ./bloat
/home/vagrant/touch_of_death/pin/pin -t /home/vagrant/touch_of_death/tracer/obj-ia32/trace.so -o bloaty.record -- ./bloaty ./bloaty
cp bloaty.record /home/vagrant/touch_of_death/record_for_fuzzbench/
cp -r ~/.critical ./
cp .critical/processed.json /home/vagrant/touch_of_death/varmeta/bloaty.json
