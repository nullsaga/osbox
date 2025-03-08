#!/bin/bash

set -ouex pipefail

#chrome 
mkdir -p /var/opt # -p just in case it exists

# Prepare alternatives directory
mkdir -p /var/lib/alternatives

# Setup repo
cat << EOF > /etc/yum.repos.d/google-chrome.repo
[google-chrome]
name=google-chrome
baseurl=https://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-google
EOF

# Import signing key
curl --retry 3 --retry-delay 2 --retry-all-errors -sL \
  -o /etc/pki/rpm-gpg/RPM-GPG-KEY-google \
  https://dl.google.com/linux/linux_signing_key.pub
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-google

# Now let's install the packages.
dnf -y install google-chrome-stable

# Clean up the yum repo (updates are baked into new images)
rm /etc/yum.repos.d/google-chrome.repo -f

# And then we do the hacky dance!
mv /var/opt/google /usr/lib/google # move this over here

#####
# Register path symlink
# We do this via tmpfiles.d so that it is created by the live system.
cat >/usr/lib/tmpfiles.d/google.conf <<EOF
L  /opt/google  -  -  -  -  /usr/lib/google
EOF
