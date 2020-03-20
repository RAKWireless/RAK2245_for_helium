#!/bin/bash

# Stop on the first sign of trouble
set -e

if [ $UID != 0 ]; then
    echo "ERROR: Operation not permitted. Forgot sudo?"
    exit 1
fi

SCRIPT_DIR=$(pwd)

# Install LoRaWAN packet forwarder repositories
INSTALL_DIR="/opt/ttn-gateway"
if [ ! -d "$INSTALL_DIR" ]; then mkdir $INSTALL_DIR; fi
pushd $INSTALL_DIR

# Build LoRa gateway app

if [ ! -d $INSTALL_DIR/lora_gateway ]; then
    git clone https://github.com/Lora-net/lora_gateway.git
fi

pushd lora_gateway
cp $SCRIPT_DIR/loragw_spi.native.c ./libloragw/src/loragw_spi.native.c
make
popd

# Build packet forwarder

if [ ! -d $INSTALL_DIR/packet_forwarder ]; then
    git clone https://github.com/Lora-net/packet_forwarder.git
fi

pushd packet_forwarder
cp $SCRIPT_DIR/lora_pkt_fwd.c ./lora_pkt_fwd/src/lora_pkt_fwd.c
rm ./lora_pkt_fwd/local_conf.json -f
make
popd

cp $SCRIPT_DIR/global_conf.json_no_gps $INSTALL_DIR/packet_forwarder/lora_pkt_fwd/global_conf.json
cp $SCRIPT_DIR/global_conf.json_no_gps $INSTALL_DIR/packet_forwarder/lora_pkt_fwd/
cp $SCRIPT_DIR/global_conf.json_have_gps $INSTALL_DIR/packet_forwarder/lora_pkt_fwd/
cp $SCRIPT_DIR/start.sh $INSTALL_DIR/packet_forwarder/lora_pkt_fwd/start.sh
cp $SCRIPT_DIR/ttn-gateway.service /lib/systemd/system/ttn-gateway.service
systemctl enable ttn-gateway.service

# leave $INSTALL_DIR
popd
