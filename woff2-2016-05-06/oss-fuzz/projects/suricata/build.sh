#!/bin/bash -eu
# Copyright 2019 Google Inc.
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

# build dependencies statically
tar -xvzf lz4-1.9.2.tar.gz
cd lz4-1.9.2
make liblz4.a
cp lib/liblz4.a /usr/local/lib/
cp lib/lz4*.h /usr/local/include/
cd ..

tar -xvzf jansson-2.12.tar.gz
cd jansson-2.12
./configure --disable-shared
make -j$(nproc)
make install
cd ..

tar -xvzf libpcap-1.9.1.tar.gz
cd libpcap-1.9.1
./configure --disable-shared
make -j$(nproc)
make install
cd ..

cd libyaml
./bootstrap
./configure --disable-shared
make -j$(nproc)
make install
cd ..

export CARGO_BUILD_TARGET="x86_64-unknown-linux-gnu"

# build project
cd suricata
sh autogen.sh
#run configure with right options
./src/tests/fuzz/oss-fuzz-configure.sh
make

cp src/fuzz_* $OUT/

# build corpuses
# default configuration file
zip -r $OUT/fuzz_confyamlloadstring_seed_corpus.zip suricata.yaml
# rebuilds rules corpus with only one rule by file
unzip ../emerging.rules.zip
cd rules
i=0
mkdir corpus
# quiet output for commands
set +x
cat *.rules | while read l; do echo $l > corpus/$i.rule; i=$((i+1)); done
set -x
zip -q -r $OUT/fuzz_siginit_seed_corpus.zip corpus
cd ../../suricata-verify

# corpus with single files
find . -name "*.pcap" | xargs zip -r $OUT/fuzz_decodepcapfile_seed_corpus.zip
find . -name "*.yaml" | xargs zip -r $OUT/fuzz_confyamlloadstring_seed_corpus.zip
find . -name "*.rules" | xargs zip -r $OUT/fuzz_siginit_seed_corpus.zip

# corpus using both rule and pcap as in suricata-verify
cd tests
i=0
mkdir corpus
set +x
ls | grep -v corpus | while read t; do
cat $t/*.rules > corpus/$i || true; echo -ne '\0' >> corpus/$i; cat $t/*.pcap >> corpus/$i || true; i=$((i+1));
done
set -x
zip -q -r $OUT/fuzz_sigpcap_seed_corpus.zip corpus
