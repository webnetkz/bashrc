#!/bin/bash

# Папка для пиров
PEERS_DIR="/etc/wireguard/peers"
WG_CONF="/etc/wireguard/wg0.conf"
WG_INTERFACE="wg0"
WG_IP_NETWORK="10.0.0."

if [ -z "$1" ]; then
  echo "Usage: $0 username"
  exit 1
fi

USERNAME="$1"
PEER_CONF="$PEERS_DIR/$USERNAME.conf"

if [ -f "$PEER_CONF" ]; then
  echo "Peer config $PEER_CONF already exists!"
  exit 1
fi

# Генерируем приватный ключ
PRIVATE_KEY=$(wg genkey)
# Генерируем публичный ключ
PUBLIC_KEY=$(echo "$PRIVATE_KEY" | wg pubkey)

# Ищем последний использованный IP
LAST_IP=$(grep AllowedIPs $PEERS_DIR/*.conf | awk -F '[./]' '{print $(NF-1)}' | sort -n | tail -1)
if [ -z "$LAST_IP" ]; then
  LAST_IP=1
fi

# Следующий IP
NEXT_IP=$((LAST_IP + 1))
if [ "$NEXT_IP" -ge 255 ]; then
  echo "IP pool exhausted"
  exit 1
fi

# Полный IP адрес для клиента
CLIENT_IP="${WG_IP_NETWORK}${NEXT_IP}/32"

# Создаём конфиг пира
cat > "$PEER_CONF" <<EOF
[Peer]
PublicKey = $PUBLIC_KEY
AllowedIPs = $CLIENT_IP
EOF

chmod 600 "$PEER_CONF"

echo "Created peer config $PEER_CONF"
echo "Private key (save to client config):"
echo "$PRIVATE_KEY"
echo "Client IP: $CLIENT_IP"

echo "Теперь можно включить пира командой:"
echo "./enable-peer.sh $USERNAME"
