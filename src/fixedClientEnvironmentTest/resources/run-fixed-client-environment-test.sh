#!/usr/bin/env bash
#
# Copyright 2018 Netherlands eScience Center
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

MYDOCKERGID=`cut -d: -f3 < <(getent group docker)`
MYUID=$UID
DOCKERGID=$MYDOCKERGID

docker network create xenontest.nlesc.nl

docker-compose -f ./src/fixedClientEnvironmentTest/resources/docker-compose/fixed.yml \
run \
-e MYUID=$UID \
-e DOCKERGID=$MYDOCKERGID \
--rm fixed \
./gradlew --no-daemon fixedClientEnvironmentTest "$@"

exit_code=$?
docker-compose -f ./src/fixedClientEnvironmentTest/resources/docker-compose/fixed.yml down

docker network rm xenontest.nlesc.nl

exit $exit_code

