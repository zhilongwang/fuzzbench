/home/vagrant/touch_of_death/AFL/afl-clang-fast++ -g -O0 -rtlib=compiler-rt -lgcc_s -std=c++11 -Iinclude -I. cms_transform_fuzzer.cc  ./src/.libs/liblcms2.a -L/usr/local/lib -larchive -o cms_transform_fuzzer
/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out -t 2000 ./cms_transform_fuzzer ../seeds/seed
/home/vagrant/touch_of_death/AFL/afl-clang-fast++ -g -O0  cms_transform_fuzzer.cc -I include/ src/.libs/liblcms2.a  -o cms_transform_fuzzer
../../../../../pin/pin -t ../../../../../tracer/obj-ia32/trace.so -o little-cms.record -- ./cms_transform_fuzzer ../seeds/seed
cp lcms.record /home/vagrant/touch_of_death/record_for_fuzzbench/
cp -r ~/.critical ./
cp .critical/processed.json /home/vagrant/touch_of_death/varmeta/lcms.json
