# HTTPS Nginx Docker

A Nginx Docker environment for using HTTPS in local development.
It automatically generates self-signed certificates and starts a web server with HTTPS.

## Requirements

- Docker
- Docker Compose

## Setup and Launch

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd <repository-name>
   ```

2. Build and start the Docker image using either method:

   a. Using the start_docker.sh script:
   ```bash
   ./start_docker.sh
   ```

   b. Using docker compose directly:
   ```bash
   docker compose up --build
   ```

3. Self-signed certificates will be automatically generated on first launch.

4. Access the following URL in your browser to verify it's working:
   ```
   https://localhost/
   ```

## Using Custom Domains

To use a custom domain, set the `DOMAIN` environment variable and add the domain to your hosts file:

1. Add the domain to your hosts file:
   ```bash
   # Linux/Mac: Edit /etc/hosts
   # Windows: Edit C:\Windows\System32\drivers\etc\hosts
   
   127.0.0.1 example.local
   ```

2. Set the domain environment variable:
   ```bash
   # When using docker compose directly:
   DOMAIN=example.local docker compose up

   # When using start_docker.sh:
   DOMAIN=example.local ./start_docker.sh
   ```

## About Certificates

- Certificates are stored in the Docker volume `https-nginx-certs`
- The following files are generated in the `/certs` directory:
  - `cert.pem`: Server certificate
  - `key.pem`: Private key
  - `rootCA.pem`: Root CA certificate

## File Structure

- `Dockerfile`: Nginx and mkcert setup
- `docker-compose.yml`: Docker environment configuration
- `nginx.conf`: Nginx HTTPS configuration
- `generate-cert.sh`: Certificate generation script
- `html/`: Static content directory
- `start_docker.sh`: Script to launch Docker environment

## Notes

- This configuration is for development environments only. Do not use in production.
- Browsers may display warnings due to the use of self-signed certificates.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
