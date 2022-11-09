/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out -t 2000 ./x509_check_cert_pkey_test
/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out -t 2000 ./tls13encryptiontest
/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out -t 2000 ./user_property_test
/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out -t 2000 ./buildtest_c_conf_api
/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out -t 2000 ./bn_internal_test
/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out -t 2000 ./http_test


../../../../../../pin/pin -t ../../../../../../tracer/obj-ia32/trace.so -o records/openssl_x509_check_cert_pkey_test.record -- ./x509_check_cert_pkey_test
../../../../../../pin/pin -t ../../../../../../tracer/obj-ia32/trace.so -o records/openssl_tls13encryptiontest.record -- ./tls13encryptiontest
../../../../../../pin/pin -t ../../../../../../tracer/obj-ia32/trace.so -o records/openssl_user_property_test.record -- ./user_property_test
../../../../../../pin/pin -t ../../../../../../tracer/obj-ia32/trace.so -o records/openssl_buildtest_c_conf_api.record -- ./buildtest_c_conf_api
../../../../../../pin/pin -t ../../../../../../tracer/obj-ia32/trace.so -o records/openssl_bn_internal_test.record -- ./bn_internal_test
../../../../../../pin/pin -t ../../../../../../tracer/obj-ia32/trace.so -o records/openssl_http_test.record -- ./http_test