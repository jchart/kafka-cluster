#/bin/bash
/opt/kafka/bin/kafka-topics.sh --zookeeper 192.168.50.11:2181 --replication-factor 3 --partition 1 --topic $1 --create
