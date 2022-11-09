#!/bin/bash -eu
# Copyright 2018 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
################################################################################

# build projects
#nettle
(
cd nettle
tar -xvf ../gmp-6.1.2.tar.bz2
cd gmp-6.1.2
#do not use assembly instructions as we do not know if they will be available on the machine who will run the fuzzer
#we could do instead --enable-fat
./configure --disable-shared --disable-assembly
make -j$(nproc)
make install
cd ..
autoreconf
./configure --disable-shared --disable-openssl
make -j$(nproc)
make install
)

#cryptopp
(
cd cryptopp
make -j$(nproc)
make install
)

#gcrypt
(
cd libgpg-error
./autogen.sh
if [ "$ARCHITECTURE" = 'i386' ]; then
    ./configure -host=i386 --disable-doc --enable-static --disable-shared
else
    ./configure --disable-doc --enable-static --disable-shared
fi
make -j$(nproc)
make install
cd ../gcrypt
./autogen.sh
if [ "$ARCHITECTURE" = 'i386' ]; then
    ./configure -host=i386 --enable-static --disable-shared --disable-doc --enable-maintainer-mode --disable-asm
else
    ./configure --enable-static --disable-shared --disable-doc --enable-maintainer-mode --disable-asm
fi
make -j$(nproc)
make install
)

#mbedtls
(
cd mbedtls
cmake . -DENABLE_PROGRAMS=0 -DENABLE_TESTING=0
make -j$(nproc) all
make install
)

#openssl
(
cd openssl
#option to not have the same exported function poly1305_blocks as in gcrypt
if [ "$ARCHITECTURE" = 'i386' ]; then
    setarch i386 ./config no-poly1305 no-shared no-threads -m32
else
    ./config no-poly1305 no-shared no-threads
fi
make build_generated libcrypto.a
make install
)

#libecc
(
cd libecc
#required by libecc
(export CFLAGS="$CFLAGS -fPIC"; make; cp build/*.a /usr/local/lib; cp -r src/* /usr/local/include/)
)

#botan
(
cd botan
#help it find libstdc++
cp /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /usr/lib/x86_64-linux-gnu/libstdc++.so
export LDFLAGS=$CXXFLAGS
if [ "$ARCHITECTURE" = 'i386' ]; then
    ./configure.py --disable-shared-library --cpu x86_32
else
    ./configure.py --disable-shared-library
fi
make -j$(nproc)
make install
)

#quickjs
(
cd quickjs
if [ "$ARCHITECTURE" = 'i386' ]; then
    make qjsc
    cp qjsc /usr/local/bin/
    make clean
    # Makefile should not override CFLAGS
    sed -i -e 's/CFLAGS=/CFLAGS+=/' Makefile
    CFLAGS="-m32" make libquickjs.a
else
    make && make install
fi
cp quickjs*.h /usr/local/include/
cp libquickjs.a /usr/local/lib/
)

ln -s /usr/bin/nodejs /usr/bin/node
mv /usr/lib/x86_64-linux-gnu/libcrypto.a /usr/lib/x86_64-linux-gnu/libcrypto_old.a
mv /usr/lib/x86_64-linux-gnu/libcrypto.so /usr/lib/x86_64-linux-gnu/libcrypto_old.so
#build fuzz target
cd ecfuzzer
if [ "$ARCHITECTURE" = 'i386' ]; then
    export GOARCH=386
#needed explicitly because of cross compilation cf https://golang.org/cmd/cgo/
    export CGO_ENABLED=1
    export CARGO_BUILD_TARGET=i686-unknown-linux-gnu
fi
zip -r fuzz_ec_seed_corpus.zip corpus/
cp fuzz_ec_seed_corpus.zip $OUT/
cp fuzz_ec.dict $OUT/

mkdir build
cd build
#no afl with long javascript initialization
if [ "$FUZZING_ENGINE" != 'afl' ]; then
    cmake ..
    make -j$(nproc)
    cp ecfuzzer $OUT/fuzz_ec
    rm -Rf *
fi

#another target without cryptopp neither javascript
cmake -DDISABLE_CRYPTOPP=ON -DDISABLE_JS=ON ..
make -j$(nproc)
cp ecfuzzer $OUT/fuzz_ec_noblocker
mv /usr/lib/x86_64-linux-gnu/libcrypto_old.a /usr/lib/x86_64-linux-gnu/libcrypto.a
mv /usr/lib/x86_64-linux-gnu/libcrypto_old.so /usr/lib/x86_64-linux-gnu/libcrypto.so