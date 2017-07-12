#!/bin/bash

set -e

if [ "$(cat /etc/hosts | grep hub | wc -l)" == "0" ]; then
  HUB=`host github.com | grep 'has address' | head -n1 | awk '{print $4}'`; \
  echo "$HUB    github-second-record.com" >> /etc/hosts
fi

_FALSE=1
_TRUE=0

while getopts "P:ST" opt; do
  case $opt in
    P)
      _RUN_AS_SECONDARY_MASTER="$OPTARG"
      ;;
    T)
      _RUN_TC_AGENT=$_TRUE
      ;;
    S)
      _RUN_SSH=$_TRUE
      ;;
  esac
done

service salt-master start 
service salt-minion start 

if [ $_RUN_SSH ]; then service ssh start; fi

if [ $_RUN_AS_SECONDARY_MASTER ]; then
  echo "syndic_master: $_RUN_AS_SECONDARY_MASTER" > /etc/salt/minion.d/syndic.conf
  service salt-syndic start
fi

while [ "$(salt-key -l accepted | grep $(hostname))" == "" ]; do
  sleep 3
  salt-key -y -a $(hostname)
done

while true; do sleep 100; done;
