#!/bin/sh

. /vagrant/properties.conf

cd /vagrant

echo "Remove old dustcloud directory"
# comment out for testng
rm -rf dustcloud
rm -rf valetudo

if [ ! -d "dustcloud" ]; then
  echo "Clone dustcloud repository"
  git clone https://github.com/dgiese/dustcloud.git /vagrant/dustcloud
  cd dustcloud
  git apply /vagrant/dustcloud.patch
fi

if [ ! -d "valetudo" ]; then
  echo "Clone valetudo repository"
  git clone https://github.com/Hypfer/Valetudo.git /vagrant/valetudo
fi

cd /vagrant/dustcloud/devices/xiaomi.vacuum/firmwarebuilder/

# download firmware
if [ ! -f "$FIRMWARE_PKG" ]; then
	wget $FIRMWARE_URL/$FIRMWARE_PKG
fi
if [ ! -f "english.pkg" ]; then
	wget https://github.com/dgiese/dustcloud/raw/master/devices/xiaomi.vacuum/original-soundpackages/encrypted/english.pkg
fi

echo "Copy public key"
cp /vagrant/*.pub id_rsa.pub

echo "Prepare imagebuilder arguments"
RUN_STMT="sudo /vagrant/dustcloud/devices/xiaomi.vacuum/firmwarebuilder/imagebuilder.sh";
RUN_STMT="${RUN_STMT} -t=Europe/Berlin";
RUN_STMT="${RUN_STMT} --disable-firmware-updates";
if [ -n "$FIRMWARE_PKG" ]; then
  RUN_STMT="${RUN_STMT} -f=$FIRMWARE_PKG";
else
  echo "FIRMWARE_PKG must be set"
  exit 1
fi

if [ -f "id_rsa.pub" ]; then
  RUN_STMT="${RUN_STMT} -k=id_rsa.pub";
else
  echo "No public-key found"
  exit 1
fi

if [ -n "$WIFI_SSID" -a -n "WIFI_PSK" ]; then
  echo "enable wifi"
  RUN_STMT="${RUN_STMT} --unprovisioned=wpa2psk --ssid=$WIFI_SSID --psk=$WIFI_PSK"
fi

if [ -n "$NTP_SERVER" ]; then
  RUN_STMT="${RUN_STMT} --ntpserver=$NTP_SERVER"
fi

if [ -n "$VALETUDO_URL" ]; then
  wget -O /vagrant/valetudo/valetudo $VALETUDO_RELEASE_URL 
  RUN_STMT="${RUN_STMT} -valetudo-path=/vagrant/valetudo"
fi

echo "Build image"
cd /vagrant/dustcloud/devices/xiaomi.vacuum/firmwarebuilder
$RUN_STMT
