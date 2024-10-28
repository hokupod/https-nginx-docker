#!/bin/bash

set -e

# Get domain from environment variable or use default
DOMAIN=${DOMAIN:-localhost}
SSL_CERTIFICATE=/certs/${DOMAIN:-localhost}/cert.pem
SSL_CERTIFICATE_KEY=/certs/${DOMAIN:-localhost}/key.pem
echo "Generating certificate for domain: $DOMAIN"

# Change to certs directory
cd /certs

# Generate certificate with minica
minica -domains "$DOMAIN" -ca-cert root-ca.pem -ca-key root-ca-key.pem || true

# Check if files exist before moving
if [ -f "root-ca-key.pem" ] && [ -f "$DOMAIN/cert.pem" ] && [ -f "$DOMAIN/key.pem" ] && [ -f "root-ca.pem" ]; then
    # Start nginx
    echo "Certificate generation successful, starting nginx..."
    envsubst < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf
    rm /etc/nginx/conf.d/default.conf.template
    nginx -g 'daemon off;'
else
    echo "Error: Certificate generation failed - some files are missing"
    ls -la
    exit 1
fi
