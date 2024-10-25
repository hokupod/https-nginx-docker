#!/bin/bash

# Generate certificates using mkcert
mkcert -install

# Get domain from environment variable or use default
DOMAIN=${DOMAIN:-localhost}
echo "Generating certificate for domain: $DOMAIN"

# Generate certificate with specified domain and localhost
mkcert -key-file /certs/key.pem -cert-file /certs/cert.pem "$DOMAIN" localhost 127.0.0.1

# Copy the root CA file so it can be installed on the host
cp "$(mkcert -CAROOT)/rootCA.pem" /certs/

# Start nginx
nginx -g 'daemon off;'
