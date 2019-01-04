#!/bin/sh

. /vagrant/properties.conf

cd /vagrant/dustcloud/devices/xiaomi.vacuum/firmwarebuilder

echo "Prepare flashing arguments"
RUN_STMT="python3 flasher.py";
if [ -n "$FIRMWARE_PKG" ]; then
  RUN_STMT="${RUN_STMT} -f output/$FIRMWARE_PKG";
else
  echo "FIRMWARE_PKG must be set"
  exit 1
fi
  
if [ -n "$VACBOT_IP" ]; then
  RUN_STMT="${RUN_STMT} -a $VACBOT_IP"
fi

echo "flash new firmware"
$RUN_STMT
