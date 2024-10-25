FROM nginx:alpine

# Install required packages
RUN apk add --no-cache \
    bash \
    nss-tools \
    gettext \
    go \
    git \
    gcc \
    musl-dev

# Install mkcert from source
RUN go install filippo.io/mkcert@latest && \
    cp /root/go/bin/mkcert /usr/local/bin/

COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./generate-cert.sh /generate-cert.sh

RUN chmod +x /generate-cert.sh

CMD ["/generate-cert.sh"]
