CC=/home/vagrant/touch_of_death/AFL/afl-clang-fast CXX=/home/vagrant/touch_of_death/AFL/afl-clang-fast++ CFLAGS="-g -O0 --rtlib=compiler-rt" CXXFLAGS="-g -O0 --rtlib=compiler-rt" ./configure CFLAGS='-g -O0 --rtlib=compiler-rt'
sudo TRIGGER_VARIABLES=true  ./hostnamectl set-hostname wzl-buster --static
sudo /home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out ./hostnamectl set-hostname wzl-buster --static
/home/vagrant/touch_of_death/pin/pin -t /home/vagrant/touch_of_death/tracer/obj-ia32/trace.so -o systemd_hostnamectl.record -- ./hostnamectl set-hostname wzl-buster --static 

TRIGGER_VARIABLES=true  ./bootctl status
/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out ./bootctl status

TRIGGER_VARIABLES=true ./systemd-analyze critical-chain
/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out ./systemd-analyze critical-chain

 sudo TRIGGER_VARIABLES=true ./systemd-run --uid=vagrant --setenv=PATH=/usr/local/bin/ --send-sighup bash
/home/vagrant/touch_of_death/AFL/afl-fuzz -i in -o out ./systemd-run --uid=vagrant --setenv=PATH=/usr/local/bin/ --send-sighup bash


sudo TRIGGER_VARIABLES=true ./systemd-nspawn --user=vagrant --private-network --network-bridge=INTERFACE --read-only --setenv=PATH=/home/  -b -M wzl

sudo TRIGGER_VARIABLES=true ./test-login


sudo /home/vagrant/touch_of_death/pin/pin -t /home/vagrant/touch_of_death/tracer/obj-ia32/trace.so -o systemd_hostnamectl.record -- ./hostnamectl set-hostname wzlbuster --static
 2146  sudo /home/vagrant/touch_of_death/pin/pin -t /home/vagrant/touch_of_death/tracer/obj-ia32/trace.so -o systemd_bootctl.record -- ./bootctl status
 2148  sudo /home/vagrant/touch_of_death/pin/pin -t /home/vagrant/touch_of_death/tracer/obj-ia32/trace.so -o systemd_systemd-analyze.record -- ./systemd-analyze critical-chain
 2150  sudo /home/vagrant/touch_of_death/pin/pin -t /home/vagrant/touch_of_death/tracer/obj-ia32/trace.so -o systemd_systemd-run.record -- ./systemd-run --uid=vagrant --setenv=PATH=/usr/local/bin/ --send-sighup bash
 2152* sudo /home/vagrant/touch_of_death/pin/pin -t /home/vagrant/touch_of_death/tracer/obj-ia32/trace.so -o systemd_systemd-nspawn.record -- ./systemd-nspawn --user=vagrant --private-network --network-bridge=INTERFACE --read-only --setenv=PATH
 2154  sudo /home/vagrant/touch_of_death/pin/pin -t /home/vagrant/touch_of_death/tracer/obj-ia32/trace.so -o systemd_test-login.record -- ./test-login
