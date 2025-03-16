cat <<EOF >/etc/yum.repos.d/docker-ce.repo
[docker-ce-stable]
name=Docker CE Stable
baseurl=https://download.docker.com/linux/fedora/\$releasever/\$basearch/stable
enabled=1
gpgcheck=1
gpgkey=https://download.docker.com/linux/fedora/gpg
EOF

dnf install -y docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

mkdir -p /usr/lib/sysctl.d
echo "net.ipv4.ip_forward = 1" >/usr/lib/sysctl.d/docker-ce.conf

sed -i "s@enabled=1@enabled=0@" /etc/yum.repos.d/docker-ce.repo
