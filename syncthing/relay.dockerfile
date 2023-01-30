FROM ubuntu:22.04

ARG TENCENTCLOUD="false"

RUN if [ $TENCENTCLOUD = "true" ]; then \
        sed -i "s/archive.ubuntu.com/mirrors.tencentyun.com/g" /etc/apt/sources.list; \
        sed -i "s/security.ubuntu.com/mirrors.tencentyun.com/g" /etc/apt/sources.list; \
    fi; \
    apt update && apt install -y syncthing-relaysrv && rm -rf /var/lib/apt/lists/*; \
    mkdir -p /etc/syncthing;

CMD ["strelaysrv", "-keys=/etc/syncthing/", "-pools= ", "-provided-by=Vankyle"]