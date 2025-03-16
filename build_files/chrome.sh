#!/bin/bash

set -ouex pipefail

mkdir -p /var/opt

mkdir -p /var/lib/alternatives

cat << EOF > /etc/yum.repos.d/google-chrome.repo
[google-chrome]
name=google-chrome
baseurl=https://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl.google.com/linux/linux_signing_key.pub
EOF

dnf install -y google-chrome-stable

rm /etc/yum.repos.d/google-chrome.repo -f

mv /var/opt/google /usr/lib/google

cat >/usr/lib/tmpfiles.d/google.conf <<EOF
L  /opt/google  -  -  -  -  /usr/lib/google
EOF
