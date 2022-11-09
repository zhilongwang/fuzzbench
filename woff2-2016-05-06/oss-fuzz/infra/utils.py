# Copyright 2020 Google LLC
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
"""Utilities for OSS-Fuzz infrastructure."""

import logging
import os
import re
import stat
import subprocess

import helper

ALLOWED_FUZZ_TARGET_EXTENSIONS = ['', '.exe']
FUZZ_TARGET_SEARCH_STRING = 'LLVMFuzzerTestOneInput'
VALID_TARGET_NAME = re.compile(r'^[a-zA-Z0-9_-]+$')


def chdir_to_root():
  """Changes cwd to OSS-Fuzz root directory."""
  # Change to oss-fuzz main directory so helper.py runs correctly.
  if os.getcwd() != helper.OSS_FUZZ_DIR:
    os.chdir(helper.OSS_FUZZ_DIR)


def execute(command, location=None, check_result=False):
  """ Runs a shell command in the specified directory location.

  Args:
    command: The command as a list to be run.
    location: The directory the command is run in.
    check_result: Should an exception be thrown on failed command.

  Returns:
    stdout, stderr, error code.

  Raises:
    RuntimeError: running a command resulted in an error.
  """

  if not location:
    location = os.getcwd()
  process = subprocess.Popen(command,
                             stdout=subprocess.PIPE,
                             stderr=subprocess.PIPE,
                             cwd=location)
  out, err = process.communicate()
  out = out.decode('utf-8', errors='ignore')
  err = err.decode('utf-8', errors='ignore')
  if err:
    logging.debug('Stderr of command \'%s\' is %s.', ' '.join(command), err)
  if check_result and process.returncode:
    raise RuntimeError(
        'Executing command \'{0}\' failed with error: {1}.'.format(
            ' '.join(command), err))
  return out, err, process.returncode


def get_fuzz_targets(path):
  """Get list of fuzz targets in a directory.

  Args:
    path: A path to search for fuzz targets in.

  Returns:
    A list of paths to fuzzers or an empty list if None.
  """
  if not os.path.exists(path):
    return []
  fuzz_target_paths = []
  for root, _, fuzzers in os.walk(path):
    for fuzzer in fuzzers:
      file_path = os.path.join(root, fuzzer)
      if is_fuzz_target_local(file_path):
        fuzz_target_paths.append(file_path)

  return fuzz_target_paths


def get_container_name():
  """Gets the name of the current docker container you are in.
  /proc/self/cgroup can be used to check control groups e.g. Docker.
  See: https://docs.docker.com/config/containers/runmetrics/ for more info.

  Returns:
    Container name or None if not in a container.
  """
  with open('/proc/self/cgroup') as file_handle:
    if 'docker' not in file_handle.read():
      return None
  with open('/etc/hostname') as file_handle:
    return file_handle.read().strip()


def is_fuzz_target_local(file_path):
  """Returns whether |file_path| is a fuzz target binary (local path).
  Copied from clusterfuzz src/python/bot/fuzzers/utils.py
  with slight modifications.
  """
  filename, file_extension = os.path.splitext(os.path.basename(file_path))
  if not VALID_TARGET_NAME.match(filename):
    # Check fuzz target has a valid name (without any special chars).
    return False

  if file_extension not in ALLOWED_FUZZ_TARGET_EXTENSIONS:
    # Ignore files with disallowed extensions (to prevent opening e.g. .zips).
    return False

  if not os.path.exists(file_path) or not os.access(file_path, os.X_OK):
    return False

  if filename.endswith('_fuzzer'):
    return True

  if os.path.exists(file_path) and not stat.S_ISREG(os.stat(file_path).st_mode):
    return False

  with open(file_path, 'rb') as file_handle:
    return file_handle.read().find(FUZZ_TARGET_SEARCH_STRING.encode()) != -1
