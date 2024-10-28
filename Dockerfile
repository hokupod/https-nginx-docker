FROM nginx:alpine

# Install required packages
RUN apk add --no-cache \
    bash \
    gettext \
    go \
    git \
    gcc \
    musl-dev

# Install minica from source
RUN go install github.com/jsha/minica@latest && \
    cp /root/go/bin/minica /usr/local/bin/

COPY ./nginx.conf.template /etc/nginx/conf.d/default.conf.template
COPY ./generate-cert.sh /generate-cert.sh

RUN chmod +x /generate-cert.sh

CMD ["/generate-cert.sh"]
