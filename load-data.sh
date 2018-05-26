#!/usr/bin/env bash
curl -s -H "Content-Type: application/json" -XPOST localhost:9201/test/_bulk --data-binary @${1}
