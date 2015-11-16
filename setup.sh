#!/bin/bash

# this script will re/configure a local .dev tld to route to a local docker-machine exposing
# https://github.com/jwilder/nginx-proxy on host port 80
# in the event the docker-machine ip changes, rerun this script

# instead of pow, which would require xip.io or individual pow entry we can
# use dnsmasq to create a .dev tld and forward all requests there
brew install dnsmasq

# Copy the default configuration file.
cp $(brew list dnsmasq | grep /dnsmasq.conf.example$) /usr/local/etc/dnsmasq.conf
# Copy the daemon configuration file into place.
echo "need sudo to configure dnsmasq service autostart, pls"
sudo cp $(brew list dnsmasq | grep /homebrew.mxcl.dnsmasq.plist$) /Library/LaunchDaemons/
# Start Dnsmasq automatically.
sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
#Create the zone, assume the default ip is being used by the local docker-machine...
echo address=/dev/$(docker-machine ip default) >> /usr/local/etc/dnsmasq.conf

# Setup local resolver
sudo tee /etc/resolver/dev >/dev/null <<EOF
nameserver 127.0.0.1
EOF

# restart dnsmasq
sudo launchctl stop homebrew.mxcl.dnsmasq
sudo launchctl start homebrew.mxcl.dnsmasq