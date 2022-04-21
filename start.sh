#!/bin/sh

mkdir -p /dev/net
if [ ! -c /dev/net/tun ]; then
                        mknod /dev/net/tun c 10 200
fi
iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
iptables -A FORWARD  -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

if [ -z "$USER" ]; then
        echo "Environment variable USER not set, not using --auth-user-pass"
else
        echo "Creating auth.txt"
        echo ${USER} > /tmp/auth.txt
        echo ${PW} >> /tmp/auth.txt
        auth="--auth-user-pass /tmp/auth.txt"
fi
if [ -z "$MANAGEMENT_PORT" ]; then
        echo "Environment variable MANAGEMENT_PORT not set, not using --management"
else
        mgmt="--management 0.0.0.0 ${MANAGEMENT_PORT}"
        echo "Opening management console at port ${MANAGEMENT_PORT}"
fi

exec openvpn ${mgmt} ${auth} --config /tmp/conf.ovpn
