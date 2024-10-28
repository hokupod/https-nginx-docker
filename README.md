# HTTPS Nginx Docker

A Docker environment for running Nginx with HTTPS in local development.
This setup automatically generates self-signed certificates using minica and configures Nginx to serve content over HTTPS.

## Requirements

- Docker
- Docker Compose

## Quick Start

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd <repository-name>
   ```

2. Start the environment (choose one method):

   a. Using the convenience script:
   ```bash
   ./start_docker.sh
   ```

   b. Using Docker Compose directly:
   ```bash
   docker compose up --build
   ```

3. Access your site:
   ```
   https://localhost/
   ```

   Note: Your browser will show a security warning because of the self-signed certificate.
   This is normal for local development.

## Custom Domain Setup

To use a custom domain instead of localhost:

1. Add your domain to your hosts file:
   ```bash
   # Linux/Mac: Edit /etc/hosts
   # Windows: Edit C:\Windows\System32\drivers\etc\hosts
   
   127.0.0.1 example.local
   ```

2. Start the server with your domain:
   ```bash
   DOMAIN=example.local ./start_docker.sh
   ```

## Project Structure

- `Dockerfile`: Sets up Nginx and installs minica
- `docker-compose.yml`: Defines the Docker services and volumes
- `nginx.conf.template`: Nginx configuration template for HTTPS
- `generate-cert.sh`: Handles certificate generation with minica
- `start_docker.sh`: Convenience script for starting the environment
- `certs/`: Directory for SSL certificates (auto-generated)
- `html/`: Place your static web content here

## Certificate Details

The setup uses minica to generate:
- A root CA certificate
- Domain-specific certificates
- Private keys

These are stored in the `certs/` directory:
- `root-ca.pem`: Root CA certificate
- `root-ca-key.pem`: Root CA private key
- `<domain>/cert.pem`: Domain certificate
- `<domain>/key.pem`: Domain private key

## Important Notes

- This setup is for development only - not for production use
- The certificates are self-signed and will trigger browser warnings
- Certificates are automatically generated on first launch
- All generated certificates are stored in a Docker volume for persistence

### Removing Certificate Warnings (Optional)

You can eliminate browser certificate warnings by adding the root CA certificate (`root-ca.pem`) to your system's trusted certificates. However, please note:

- This is entirely at your own risk
- Only do this on development machines
- Never trust self-signed certificates on production systems

The process varies by operating system:

#### Windows
1. Copy `certs/root-ca.pem` to your local machine
2. Double-click the certificate file
3. Click "Install Certificate"
4. Select "Local Machine" and "Place all certificates in the following store"
5. Browse and select "Trusted Root Certification Authorities"
6. Complete the wizard

#### macOS
1. Copy `certs/root-ca.pem` to your local machine
2. Double-click the certificate file
3. Add it to your Keychain
4. Open Keychain Access
5. Find the certificate
6. Double-click it and expand "Trust"
7. Set "When using this certificate" to "Always Trust"

#### Linux (Ubuntu/Debian)
```bash
sudo cp certs/root-ca.pem /usr/local/share/ca-certificates/minica-root-ca.crt
sudo update-ca-certificates
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
