#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 peer_name"
  exit 1
fi

PEER_CONF="/etc/wireguard/peers/$1.conf"

if [ ! -f "$PEER_CONF" ]; then
  echo "Peer config not found: $PEER_CONF"
  exit 1
fi

PublicKey=$(grep '^PublicKey' "$PEER_CONF" | awk -F '= ' '{print $2}')

if [ -z "$PublicKey" ]; then
  echo "PublicKey missing in $PEER_CONF"
  exit 1
fi

# Удаляем пира из WireGuard
wg set wg0 peer "$PublicKey" remove
echo "Peer '$1' disabled."
