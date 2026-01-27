# Running Example Self-Hosted Services

Your homelab dashboard is now ready to use with working example services!

## Quick Setup

### 1. Start the Dashboard (Already Running)
```bash
docker compose up -d
```
The dashboard is now running at **http://localhost:3000**

### 2. Start Example Services
In a separate terminal, run the optional services:
```bash
docker compose -f docker-compose.yml -f docker-compose.services.yml up -d
```

This will deploy 10+ self-hosted services including:
- 🎬 **Jellyfin** (Media Server)
- 🔐 **Vaultwarden** (Password Manager)  
- ☁️ **Nextcloud** (File Sync)
- 📸 **Immich** (Photo Management)
- 🔄 **Gitea** (Git Server)
- 📄 **Paperless** (Document Management)
- ⚡ **Transmission** (Torrent Client)
- 📊 **Grafana** + **Prometheus** (Monitoring)
- 🛡️ **AdGuard** (DNS/Ad Blocking)

### 3. Load Services into Dashboard
1. Register/Login at http://localhost:3000
2. Click **"Load Examples"** button
3. Your dashboard will automatically populate with all running services!

### 4. Access Your Services
Click any service tile in the dashboard to open it in a new tab.

## Service Access URLs

After deploying example services, they're available at:

| Service | URL | Username | Password |
|---------|-----|----------|----------|
| Jellyfin | http://localhost:8096 | Create on first access | - |
| Vaultwarden | http://localhost:8080 | Create on first access | - |
| Nextcloud | http://localhost:8081 | Create on first access | - |
| Immich | http://localhost:2283 | Create on first access | - |
| Gitea | http://localhost:3001 | Create on first access | - |
| Paperless | http://localhost:8000 | admin | admin |
| Transmission | http://localhost:9091 | (None) | (None) |
| AdGuard | http://localhost:3000 | admin | admin |
| Grafana | http://localhost:3002 | admin | admin123 |
| Prometheus | http://localhost:9090 | N/A | N/A |

## Manage Services

### Stop Example Services
```bash
docker compose -f docker-compose.yml -f docker-compose.services.yml down
```

### Restart Specific Service
```bash
docker compose -f docker-compose.yml -f docker-compose.services.yml restart jellyfin
```

### View Service Logs
```bash
docker compose -f docker-compose.yml -f docker-compose.services.yml logs -f jellyfin
```

### View All Running Services
```bash
docker compose -f docker-compose.yml -f docker-compose.services.yml ps
```

## Dashboard Features

### Add Custom Services
1. Go to "My Services" tab
2. Click "+ Add Service"
3. Fill in the details:
   - **Name**: Service display name
   - **URL**: Where the service is hosted
   - **Description**: What it does
   - **Category**: Type/category
   - **Icon**: Any emoji

### Share Services with Friends
1. Click the share button (🔗) on any service
2. Enter your friend's email
3. They'll be able to see shared services in "Shared with Me" tab

### Delete Services
1. Click the trash button (🗑️) on any service
2. Confirmed services are removed from your dashboard

## Troubleshooting

### Services Not Starting?
```bash
# Check service status
docker compose -f docker-compose.yml -f docker-compose.services.yml ps

# View error logs
docker compose -f docker-compose.yml -f docker-compose.services.yml logs
```

### Port Already in Use?
```bash
# Find what's using port 8096
lsof -i :8096

# Kill the process or change the port in docker-compose.services.yml
```

### Service Connection Refused?
Wait 30 seconds for services to fully initialize, then refresh.

## Next Steps

1. **Customize Services**: Edit `docker-compose.services.yml` to change ports, volumes, or credentials
2. **Set Up Backups**: Use `docker volume` commands to backup important data
3. **Enable HTTPS**: Configure a reverse proxy (Nginx, Caddy) for remote access
4. **Add More Services**: Edit the compose file to add additional self-hosted applications

See **SERVICES_DEPLOYMENT.md** for advanced configuration and deployment options.
