DEFAULT_VERSION="20.10.7"
DOCKER_VERSION="${1:-$DEFAULT_VERSION}"
DOCKER_ZIPFILE="docker-${DOCKER_VERSION}.tgz"
wget "https://download.docker.com/linux/static/stable/aarch64/${DOCKER_ZIPFILE}"


tar -zxvf ${DOCKER_ZIPFILE}
rm -rf ${DOCKER_ZIPFILE}

mv docker/* /usr/bin/
rm -rf docker/

cat > /usr/lib/systemd/system/docker.service <<EOF
[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com
After=network-online.target firewalld.service
Wants=network-online.target

[Service]
Type=notify
ExecStart=/usr/bin/dockerd
ExecReload=/bin/kill -s HUP $MAINPID
LimitNOFILE=infinity
LimitNPROC=infinity
TimeoutStartSec=0
Delegate=yes
KillMode=process
Restart=on-failure
StartLimitBurst=3
StartLimitInterval=60s

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl restart docker
docker version
