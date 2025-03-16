#!/bin/bash

set -ouex pipefail

mkdir -p /var/opt # -p just in case it exists

mkdir -p /var/lib/alternatives

# cat << EOF > /etc/yum.repos.d/google-chrome.repo
# [google-chrome]
# name=google-chrome
# baseurl=https://dl.google.com/linux/chrome/rpm/stable/x86_64
# enabled=1
# gpgcheck=1
# repo_gpgcheck=1
# gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-google
# EOF
#
# curl --retry 3 --retry-delay 2 --retry-all-errors -sL \
#   -o /etc/pki/rpm-gpg/RPM-GPG-KEY-google \
#   https://dl.google.com/linux/linux_signing_key.pub
# rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-google
#
# dnf -y install google-chrome-stable

dnf -y install https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm

rm /etc/yum.repos.d/google-chrome.repo -f

mv /var/opt/google /usr/lib/google

cat >/usr/lib/tmpfiles.d/google.conf <<EOF
L  /opt/google  -  -  -  -  /usr/lib/google
EOF
