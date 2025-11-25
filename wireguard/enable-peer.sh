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

# Получаем значения из файла
PublicKey=$(grep '^PublicKey' "$PEER_CONF" | awk -F '= ' '{print $2}')
AllowedIPs=$(grep '^AllowedIPs' "$PEER_CONF" | awk -F '= ' '{print $2}')

if [ -z "$PublicKey" ] || [ -z "$AllowedIPs" ]; then
  echo "PublicKey or AllowedIPs missing in $PEER_CONF"
  exit 1
fi

# Добавляем пира в WireGuard
wg set wg0 peer "$PublicKey" allowed-ips "$AllowedIPs"
echo "Peer '$1' enabled."