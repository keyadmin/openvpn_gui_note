#!/bin/bash
cd ~/EasyRSA-3.0.4/
echo "enter name client Key generation: "
read name_key_pair
sudo ./easyrsa build-client-full $name_key_pair
echo "Step 1:"
echo "----------------------------------------------"
sudo ls ~/EasyRSA-3.0.4/pki/private | grep $name_key_pair
sudo ls ~/EasyRSA-3.0.4/pki/issued | grep $name_key_pair
echo "----------------------------------------------"
sudo cp ~/EasyRSA-3.0.4/pki/private/"$name_key_pair".key ~/client-configs/keys/ && sudo cp ~/EasyRSA-3.0.4/pki/issued/"$name_key_pair".crt ~/client-configs/keys/
echo "Step 2:"
sudo ls ~/client-configs/keys
echo "----------------------------------------------"
cd ../client-configs
sudo ./make_config.sh $name_key_pair
echo "file ovpn created: ~/client-configs/files/"$name_key_pair".ovpn"
echo "END!"

set -e
echo "ENTER IP STATIC FOR USER:"
read ipaddress_static
sudo chmod -R 777 /etc/openvpn/ccd | sudo echo "ifconfig-push $ipaddress_static 255.255.255.255" > /etc/openvpn/ccd/"$name_key_pair"
echo "ipaddress static is:"
sudo cat /etc/openvpn/ccd/"$name_key_pair"

