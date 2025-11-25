#!/bin/bash

IPSERVER=
PORTWG=

SERVER_ENDPOINT="$IPSERVER:$PORTWG"

# Папки
PEERS_DIR="/etc/wireguard/peers"
CLIENT_CONFIGS_DIR="/etc/wireguard/client-configs"

if [ -z "$1" ]; then
  echo "Usage: $0 username"
  exit 1
fi

USERNAME="$1"

PEER_CONF="$PEERS_DIR/$USERNAME.conf"
PRIVATE_KEY_FILE="/etc/wireguard/keys/private_$USERNAME"
CLIENT_CONF="$CLIENT_CONFIGS_DIR/$USERNAME.conf"

if [ ! -f "$PEER_CONF" ]; then
  echo "Peer config $PEER_CONF не найден!"
  exit 1
fi

if [ ! -f "$PRIVATE_KEY_FILE" ]; then
  echo "Приватный ключ клиента не найден: $PRIVATE_KEY_FILE"
  exit 1
fi

# Читаем приватный ключ
PRIVATE_KEY=$(cat "$PRIVATE_KEY_FILE")

mkdir -p "$CLIENT_CONFIGS_DIR"

# Читаем публичный ключ сервера
SERVER_PUBLIC_KEY=$(wg show wg0 public-key)
if [ -z "$SERVER_PUBLIC_KEY" ]; then
  echo "Не удалось получить публичный ключ сервера wg0"
  exit 1
fi

# Получаем IP клиента из AllowedIPs
CLIENT_IP=$(grep AllowedIPs "$PEER_CONF" | awk -F '= ' '{print $2}')
if [ -z "$CLIENT_IP" ]; then
  echo "Не найден AllowedIPs в $PEER_CONF"
  exit 1
fi

# Формируем конфиг клиента
cat > "$CLIENT_CONF" <<EOF
[Interface]
PrivateKey = $PRIVATE_KEY
Address = $CLIENT_IP
DNS = 8.8.8.8

[Peer]
PublicKey = $SERVER_PUBLIC_KEY
Endpoint = $SERVER_ENDPOINT
AllowedIPs = 0.0.0.0/0, ::/0
PersistentKeepalive = 25
EOF

echo "Создан клиентский конфиг: $CLIENT_CONF"

# Генерируем QR код в терминале
qrencode -t ansiutf8 < "$CLIENT_CONF"

echo "QR-код конфигурации выше (отсканируй его мобильным приложением WireGuard)"

# Для сохранения PNG раскомментируй:
# qrencode -o "$CLIENT_CONFIGS_DIR/$USERNAME.png" < "$CLIENT_CONF"
