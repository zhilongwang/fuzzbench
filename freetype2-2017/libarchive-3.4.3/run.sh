sudo apt-get install -y autoconf libtool wget bzlib-dev
sudo apt install libbz2-dev
sudo apt-get install libxml2-dev libxslt1-dev
CC=/home/vagrant/touch_of_death/AFL/afl-clang-fast CXX=/home/vagrant/touch_of_death/AFL/afl-clang-fast++ CFLAGS="-g -O0 -I/usr/include/libxml2" CXXFLAGS="-g -O0 -I/usr/include/libxml2" ./configure
