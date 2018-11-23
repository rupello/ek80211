#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

set -ex

echo "checking required commands"
which jq || exit 1
which docker || exit 1
which tshark || exit 1

echo "waiting for elk to start..."
elk_health=""
until [ "${elk_health}" == '"healthy"' ]; do
    elk_health=$(docker inspect elk | jq '. | .[0].State.Health.Status')
    sleep 3
done

# download the filebeat container
docker pull docker.elastic.co/beats/filebeat:6.2.4

# pass in -r <file> to specify a file or -i <interface>
tshark -I -Tek $@ \
    -Y radiotap.flags.badfcs==0 \
    -e _ws.col.Info \
    -e wlan_radio.signal_dbm \
    -e wlan_radio.noise_dbm \
    -e wlan.duration \
    -e wlan_radio.preamble \
    -e wlan_radio.duration \
    -e wlan_radio.frequency \
    -e wlan_radio.channel \
    -e wlan_radio.ifs \
    -e wlan.sa -e wlan.sa_resolved \
    -e wlan.ra -e wlan.ra_resolved \
    -e wlan.ta -e wlan.ta_resolved \
    -e wlan.da -e wlan.da_resolved \
    -e wlan.fc.type -e wlan.fc.subtype -e wlan.fc.type_subtype \
    -e wlan.bssid \
    -e wlan.ssid \
    -e wlan.bssid_resolved \
    -e wlan.qbss.cu \
    | docker run --net elasticsearch_elknet -i \
        -v ${DIR}/filebeat/filebeat.yml:/usr/share/filebeat/filebeat.yml \
        docker.elastic.co/beats/filebeat:6.2.4
