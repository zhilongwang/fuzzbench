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

function compile_fuzzer {
  package=$1
  function=$2
  fuzzer=$3

  # Compile and instrument all Go files relevant to this fuzz target.
  go-fuzz -func $function -o $fuzzer.a $package

  # Link Go code ($fuzzer.a) with fuzzing engine to produce fuzz target binary.
  $CXX $CXXFLAGS $LIB_FUZZING_ENGINE $fuzzer.a -o $OUT/$fuzzer
}

compile_fuzzer github.com/google/go-attestation/attest FuzzParseEventLog \
    parse_event_log_fuzzer
compile_fuzzer github.com/google/go-attestation/attest FuzzParseAKPublic12 \
    parse_ak_public12_fuzzer
compile_fuzzer github.com/google/go-attestation/attest FuzzParseAKPublic20 \
    parse_ak_public20_fuzzer
compile_fuzzer github.com/google/go-attestation/attest FuzzParseEKCertificate \
    parse_ek_certificate_fuzzer
