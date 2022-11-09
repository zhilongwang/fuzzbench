# jsoncpp example

## build jsoncpp

* Requirement

    * ubuntu 14.04
    * g++: `sudo apt-get -y install g++`
    * cmake > 3.0: `sudo apt-get -y install cmake3`

* uninstall libjsoncpp library

    ``` bash
    sudo apt-get -y remove libjsoncpp0
    sudo apt-get -y remove libjsoncpp-dev
    ```

* build

    ``` bash
    git clone -b 1.8.2 https://github.com/open-source-parsers/jsoncpp.git
    cd jsoncpp
    mkdir build/release
    cd build/release
    cmake -DCMAKE_BUILD_TYPE=release -DBUILD_STATIC_LIBS=ON -DBUILD_SHARED_LIBS=OFF -DARCHIVE_INSTALL_DIR=. -G "Unix Makefiles" ../..
    make
    sudo make install
    ```

