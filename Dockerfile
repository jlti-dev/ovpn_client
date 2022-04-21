#Smallest Base Image
FROM alpine:latest

LABEL maintainer="Lars Tilsner <lars.tilsner@systema-projekte.de>"
RUN apk add --no-cache --update openvpn iptables

WORKDIR /tmp
COPY start.sh /tmp/start.sh

CMD /bin/sh /tmp/start.sh
