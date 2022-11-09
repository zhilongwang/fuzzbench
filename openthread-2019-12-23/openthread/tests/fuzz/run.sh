/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out -t 2000 ./ip6-send-fuzzer 123.txt
../../../../../../../pin/pin -t ../../../../../../../tracer/obj-ia32/trace.so -o openthread.record -- ./ip6-send-fuzzer 123.txt
cp openthread.record /home/vagrant/touch_of_death/record_for_fuzzbench/
cp -r ~/.critical ./
cp .critical/processed.json /home/vagrant/touch_of_death/varmeta/openthread.json
