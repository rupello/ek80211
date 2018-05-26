## Overview

This app uses tshark to collect and parse 802.11 packets from a WLAN interface in monitor mode.
Packets are loaded into elasticsearch using filebeat & can be visualized with Kibana.
```
  wlan-interface -> tshark -> filebeat(docker) -> elasticsearch/kibana(docker)
```
the script `hopper.sh` will hop through a defined list of WLAN channels (works on MacOSX only)

Requires:
 - MacOSX (but should be easily ported to Linux)
 - tshark
 - Docker

## Instructions

Start logstash/elaticsearch/kibana
```buildoutcfg
cd elasticsearch
docker-compose up
```

Start WLAN channel hopper:
```buildoutcfg
sudo ./hopper.sh
```

Start collecting packets:
```buildoutcfg
./collect.sh
```

View the data in Kibana at [http://localhost:5601/](http://localhost:5601/)

## References
https://www.h21lab.com/tools/tshark-elasticsearch
https://www.elastic.co/blog/analyzing-network-packets-with-wireshark-elasticsearch-and-kibana
