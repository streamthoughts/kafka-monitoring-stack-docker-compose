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

DIR=$(readlink -f $0 | xargs dirname)

echo -e "\n🐳 Starting Zookeeper..."
docker-compose -f $DIR/zk-kafka-single-node-secured-stack.yml up -d zk1

echo "Creating default kafka user for SASL/SCRAM"
. "${DIR}"/bin/create-admin-scram-users

echo -e "\n🐳 Starting Kafka Brokers..."
docker-compose -f $DIR/zk-kafka-single-node-secured-stack.yml up -d
docker-compose -f $DIR/zk-kafka-single-node-secured-stack.yml ps

echo -e "\n------------------------------------------------------------------------------------------------------"
echo -e "Grafana (Login : admin / Password : kafka) : http://localhost:3000"
echo -e "Prometheus : http://localhost:9090"
echo -e "\n------------------------------------------------------------------------------------------------------"

exit 0
