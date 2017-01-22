#/bin/bash
/opt/kafka/bin/kafka-console-consumer.sh --from-beginning --topic $1 --bootstrap-server localhost:9092 --from-beginning
