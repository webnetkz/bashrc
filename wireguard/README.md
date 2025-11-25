chmod +x enable-peer.sh

wg show wg0 peers

mkdir /etc/wireguard/peers/
mkdir /etc/wireguard/keys/

change IP:PORT in generate-client-config.sh
