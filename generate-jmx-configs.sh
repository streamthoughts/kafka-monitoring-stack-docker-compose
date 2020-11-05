#!/usr/bin/env bash
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements. See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License. You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

DIR=$(dirname "$0")
CONFIG_DIR=$(dirname "$0")/etc

rm -rf $CONFIG_DIR/jmx_exporter && mkdir -p $CONFIG_DIR/jmx_exporter

generate_jmx_exporter_cfg (){
  service="$1"
  echo -e "\n⏳ Generate JMX exporter configuration for $service"
  name=`echo $service  | awk -F ":" '{ print $1'} `
  cat template/jmx_exporter_kafka_broker.yml | sed s,%HOST_PORT%,$service,g  > $CONFIG_DIR/jmx_exporter/config_$name.yml
}

for i in kafka101:9992 kafka102:9993 kafka103:9994; do 
    generate_jmx_exporter_cfg "$i"
done  

exit 0
