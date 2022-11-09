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
"""Builds and runs specific OSS-Fuzz project's fuzzers for CI tools."""
import json
import logging
import os
import sys

# pylint: disable=wrong-import-position
# pylint: disable=import-error
sys.path.append(os.path.join(os.environ['OSS_FUZZ_ROOT'], 'infra', 'cifuzz'))
import cifuzz

# TODO: Turn default logging to INFO when CIFuzz is stable
logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.DEBUG)


def main():
  """Build OSS-Fuzz project's fuzzers for CI tools.
  This script is used to kick off the Github Actions CI tool. It is the
  entrypoint of the Dockerfile in this directory. This action can be added to
  any OSS-Fuzz project's workflow that uses Github.

  Note: The resulting clusterfuzz binaries of this build are placed in
  the directory: ${GITHUB_WORKSPACE}/out

  Required environment variables:
    OSS_FUZZ_PROJECT_NAME: The name of OSS-Fuzz project.
    GITHUB_REPOSITORY: The name of the Github repo that called this script.
    GITHUB_SHA: The commit SHA that triggered this script.
    GITHUB_EVENT_NAME: The name of the hook event that triggered this script.
    GITHUB_EVENT_PATH:
      The path to the file containing the POST payload of the webhook:
      https://help.github.com/en/actions/reference/virtual-environments-for-github-hosted-runners#filesystems-on-github-hosted-runners
    GITHUB_WORKSPACE: The shared volume directory where input artifacts are.
    DRY_RUN: If true, no failures will surface.
    SANITIZER: The sanitizer to use when running fuzzers.

  Returns:
    0 on success or 1 on Failure.
  """
  oss_fuzz_project_name = os.environ.get('OSS_FUZZ_PROJECT_NAME')
  github_repo_name = os.path.basename(os.environ.get('GITHUB_REPOSITORY'))
  commit_sha = os.environ.get('GITHUB_SHA')
  event = os.environ.get('GITHUB_EVENT_NAME')
  workspace = os.environ.get('GITHUB_WORKSPACE')
  sanitizer = os.environ.get('SANITIZER').lower()

  # Check if failures should not be reported.
  dry_run = (os.environ.get('DRY_RUN').lower() == 'true')

  # The default return code when an error occurs.
  returncode = 1
  if dry_run:
    # Sets the default return code on error to success.
    returncode = 0

  if not workspace:
    logging.error('This script needs to be run in the Github action context.')
    return returncode

  if event == 'push' and not cifuzz.build_fuzzers(oss_fuzz_project_name,
                                                  github_repo_name,
                                                  workspace,
                                                  commit_sha=commit_sha,
                                                  sanitizer=sanitizer):
    logging.error('Error building fuzzers for project %s with commit %s.',
                  oss_fuzz_project_name, commit_sha)
    return returncode

  if event == 'pull_request':
    with open(os.environ.get('GITHUB_EVENT_PATH'), encoding='utf-8') as file:
      event = json.load(file)
      pr_ref = 'refs/pull/{0}/merge'.format(event['pull_request']['number'])
      if not cifuzz.build_fuzzers(oss_fuzz_project_name,
                                  github_repo_name,
                                  workspace,
                                  pr_ref=pr_ref,
                                  sanitizer=sanitizer):
        logging.error(
            'Error building fuzzers for project %s with pull request %s.',
            oss_fuzz_project_name, pr_ref)
        return returncode

  out_dir = os.path.join(workspace, 'out')
  if cifuzz.check_fuzzer_build(out_dir, sanitizer=sanitizer):
    return 0
  return returncode


if __name__ == '__main__':
  sys.exit(main())
