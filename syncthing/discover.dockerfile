FROM ubuntu:22.04

ARG TENCENTCLOUD="false"

RUN if [ $TENCENTCLOUD = "true" ]; then \
        sed -i "s/archive.ubuntu.com/mirrors.tencentyun.com/g" /etc/apt/sources.list; \
        sed -i "s/security.ubuntu.com/mirrors.tencentyun.com/g" /etc/apt/sources.list; \
    fi; \
    apt update && apt install -y syncthing-discosrv && rm -rf /var/lib/apt/lists/*; \
    mkdir -p /var/syncthing;

CMD ["stdiscosrv", "-http", "--db-dir=/var/syncthing/discovery.db"]