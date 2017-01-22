#/bin/bash
/opt/kafka/bin/kafka-console-consumer.sh --from-beginning --topic $1 --zookeeper 192.168.50.11:2181,192.168.50.12:2181,192.168.50.13:2181
