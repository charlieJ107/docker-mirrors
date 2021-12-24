FROM nginx:latest

RUN apt update && \
    apt install certbot python3-certbot-nginx -y && \
    apt clean && rm -rf /var/lib/apt/lists/*

