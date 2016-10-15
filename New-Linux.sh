#! /bin/bash
cat <<EOT >> /etc/sysctl.conf
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.icmp_echo_ignore_all = 1
net.ipv4.ip_default_ttl = 128
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
EOT
grep -v 'deb cd' /etc/apt/sources.list > /etc/apt/sources1.list; mv /etc/apt/sources1.list /etc/apt/sources.list
apt-get install -y linux-headers-$(uname -r) gcc make unattended-upgrades
