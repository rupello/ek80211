```
.es(*, timefield=timestamp, split="layers.wlan.wlan_fc_wlan_fc_type:3").lines(stack=true,fill=3,width=1).mvavg(5)

.es(index=packets-*, timefield=timestamp,split=layers.wlan_ssid:10, metric=avg:layers.wlan_radio_signal_dbm).points(weight=2)
.es(index=packets-*, timefield=timestamp,split=layers.wlan_ssid:10, metric=avg:layers.wlan_radio_signal_dbm).points(weight=2).legend(position=se)

.es(*,timefield=timestamp,metric=avg:layers.wlan_qbss_cu, split=layers.wlan_ssid:10 ).points()
```

Active Channels:
```
.es(*,timefield=timestamp, split=layers.wlan_radio_channel:10 ).lines(stack=true,fill=3,width=0).mvavg(3)
```

https://www.h21lab.com/tools/tshark-elasticsearch
https://www.elastic.co/blog/analyzing-network-packets-with-wireshark-elasticsearch-and-kibana
