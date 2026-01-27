# Homelab Services Deployment Guide

This guide explains how to deploy working example self-hosted services for your homelab dashboard.

## Quick Start

### Deploy All Example Services

Run the services alongside your main homelab dashboard:

```bash
# Start both the main dashboard AND example services
docker compose -f docker-compose.yml -f docker-compose.services.yml up -d

# Stop all services
docker compose -f docker-compose.yml -f docker-compose.services.yml down
```

### Deploy Only Main Dashboard (No Examples)

```bash
# This is the default - runs just the dashboard
docker compose up -d
```

### Deploy Specific Services Only

```bash
# Deploy only Jellyfin and Vaultwarden
docker compose -f docker-compose.yml -f docker-compose.services.yml up -d jellyfin vaultwarden

# Deploy only monitoring stack (Prometheus + Grafana)
docker compose -f docker-compose.yml -f docker-compose.services.yml up -d prometheus grafana
```

## Available Services

All services are configured to run on `localhost` with the ports listed below. After deploying, visit the "Load Examples" button in your dashboard to automatically add them.

### Media & Content
- **Jellyfin** - `http://localhost:8096`
  - Media server for movies, TV shows, music, and personal videos
  - Default credentials: Create account on first login
  - Requires: Media files mounted at `/media`

### Security & Authentication
- **Vaultwarden** - `http://localhost:8080`
  - Password manager (Bitwarden-compatible)
  - Default credentials: Create account on first login
  - Features: Secure password storage, auto-fill, organization sharing

### Cloud Storage
- **Nextcloud** - `http://localhost:8081`
  - File sync, sharing, and collaboration
  - Default credentials: Will prompt on first access
  - Database: SQLite (use MySQL for production)

### Photos & Videos
- **Immich** - `http://localhost:2283`
  - Photo and video management with face recognition and search
  - Default credentials: Create account on first login
  - Includes: AI tagging, duplicate detection, timeline view

### Development & Source Control
- **Gitea** - `http://localhost:3001`
  - Self-hosted Git server (GitHub alternative)
  - SSH access: `ssh://localhost:2222`
  - Default credentials: Create account on first login

### Network & DNS
- **AdGuard Home** - `http://localhost:3000`
  - Ad blocking and DNS server (Pi-hole alternative)
  - Blocks ads network-wide
  - Set as primary DNS on devices: `127.0.0.1:53`

### Document Management
- **Paperless-ngx** - `http://localhost:8000`
  - Document scanning and organization
  - OCR support (English by default)
  - Default username/password: `admin` / `admin`

### Downloads & Torrents
- **Transmission** - `http://localhost:9091`
  - BitTorrent client with web interface
  - Downloads stored in `transmission_downloads` volume
  - Default credentials: No authentication required

### Monitoring & Observability
- **Prometheus** - `http://localhost:9090`
  - Time-series metrics database
  - Scrapes metrics from services
  - 15-day data retention by default

- **Grafana** - `http://localhost:3002`
  - Dashboard visualization for Prometheus metrics
  - Default username: `admin`
  - Default password: `admin123` (change immediately)
  - Pre-configured Prometheus data source

## Configuration & Customization

### Change Default Passwords

Edit `docker-compose.services.yml` before deploying:

```yaml
environment:
  - GF_SECURITY_ADMIN_PASSWORD=YourNewPassword123  # Grafana
```

### Mount Local Media for Jellyfin

```yaml
volumes:
  - /your/media/path:/media:ro  # Add your media directory
```

### Configure DNS for AdGuard

1. Access `http://localhost:3000` in your browser
2. Go to Settings > DNS Settings
3. Set upstream DNS servers (e.g., 8.8.8.8, 1.1.1.1)
4. Configure devices to use your server as DNS

### Enable HTTPS with Reverse Proxy

Use Nginx with Let's Encrypt for production:

```yaml
services:
  nginx-proxy:
    image: jwilder/nginx-proxy
    ports:
      - "443:443"
      - "80:80"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
```

## Accessing Services from Remote

To access services outside your local network:

### Option 1: VPN
- Set up WireGuard or OpenVPN on your homelab
- Connect to VPN, then access services via `localhost` ports

### Option 2: Reverse Proxy with Domain
- Get a domain (e.g., `homelab.example.com`)
- Configure Nginx/Caddy as reverse proxy
- Use Let's Encrypt for SSL/TLS

### Option 3: SSH Tunnel
```bash
ssh -L 8096:localhost:8096 user@homelab.example.com
# Then access http://localhost:8096
```

## Troubleshooting

### Services Not Starting
```bash
# Check logs
docker compose -f docker-compose.yml -f docker-compose.services.yml logs -f [service-name]

# Verify ports aren't in use
netstat -an | grep LISTEN
```

### Database Connection Errors
```bash
# Restart database services first
docker compose -f docker-compose.yml -f docker-compose.services.yml restart immich-db
```

### Out of Disk Space
```bash
# Check volume usage
docker volume ls
docker volume inspect [volume-name]

# Clean up unused volumes
docker volume prune
```

### Forgot Credentials
- Most services can be reset by removing their volumes
- Example: `docker volume rm homelab-ai-code_grafana_storage`
- Redeploy service: `docker compose up -d grafana`

## Performance Tips

1. **Resource Limits**: Services can be memory-hungry; add limits in compose file:
   ```yaml
   services:
     jellyfin:
       deploy:
         resources:
           limits:
             memory: 2G
   ```

2. **Database Optimization**: Use PostgreSQL instead of SQLite for Nextcloud/Paperless in production

3. **Disable Unused Services**: Only run services you actively use

4. **Regular Backups**: Backup volumes periodically:
   ```bash
   docker run --rm -v [volume-name]:/data -v $(pwd):/backup alpine tar czf /backup/backup.tar.gz /data
   ```

## Adding Custom Services

To add your own service to the dashboard:

1. Add it to `docker-compose.services.yml` (optional)
2. Go to dashboard → "Add Service"
3. Fill in:
   - Name: Service display name
   - URL: `http://localhost:PORT`
   - Description: What it does
   - Category: Type of service
   - Icon: Use emoji

## Support & Documentation

- Jellyfin Docs: https://jellyfin.org/docs/
- Nextcloud Docs: https://docs.nextcloud.com/
- Gitea Docs: https://docs.gitea.io/
- Vaultwarden Docs: https://github.com/dani-garcia/vaultwarden/wiki
- Immich Docs: https://immich.app/docs/
