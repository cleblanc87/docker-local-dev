
#Create the zone, assume the default ip is being used by the local docker-machine...
echo address=/dev/$(docker-machine ip default) >> /usr/local/etc/dnsmasq.conf
# restart dnsmasq
sudo launchctl stop homebrew.mxcl.dnsmasq
sudo launchctl start homebrew.mxcl.dnsmasq