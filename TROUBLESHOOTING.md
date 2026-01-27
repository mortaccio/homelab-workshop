# 🔧 Troubleshooting Guide

## Common Issues & Solutions

### ❌ Installation Issues

#### Node.js not found
```bash
# Check if installed
node --version

# Install from https://nodejs.org/
# Choose LTS version (16+)
```

#### npm install fails
```bash
# Clear cache
npm cache clean --force

# Reinstall
npm install --legacy-peer-deps

# If still fails, try
npm install --no-audit --no-fund
```

#### Permission denied setup.sh
```bash
chmod +x setup.sh
./setup.sh
```

---

### ❌ Server Issues

#### Port 5000 already in use
```bash
# Option 1: Use different port
echo "PORT=5001" >> .env

# Option 2: Kill process on port 5000
# Linux/Mac:
lsof -i :5000
kill -9 <PID>

# Windows:
netstat -ano | findstr :5000
taskkill /PID <PID> /F
```

#### Backend crashes on startup
```bash
# Check for syntax errors
cd server
npm run build

# Check error messages in console
# Common: missing dependencies
npm install

# Reset database
rm homelab.db
npm run dev
```

#### Database lock error
```bash
# Close all instances
# Windows: Restart terminal
# Linux: killall node

# Remove lock file
rm homelab.db-*

# Restart
npm run dev
```

---

### ❌ Frontend Issues

#### Port 3000 already in use
```bash
# Edit client/vite.config.ts
# Change port: 3000 to port: 3001
```

#### Blank page loading
```bash
# Check browser console (F12)
# Common issues:
# - Backend not running
# - API URL incorrect
# - CORS blocked

# Check:
curl http://localhost:5000/api/health
```

#### Static files not loading
```bash
# Rebuild frontend
cd client
npm run build

# Check dist folder created
ls client/dist/
```

#### CORS errors
```bash
# Error: "Access-Control-Allow-Origin"
# Solution: Ensure backend runs on :5000
# Frontend runs on :3000

# Or add to server/src/index.ts:
app.use(cors({
  origin: 'http://localhost:3000',
  credentials: true
}));
```

---

### ❌ Authentication Issues

#### Cannot login after registration
```bash
# Check password requirements
# Password must match on registration

# Reset database and retry
rm homelab.db
npm run dev

# Then register + login fresh
```

#### JWT token expired
```bash
# Tokens expire after 7 days
# User must login again (normal behavior)

# To change expiration, edit:
# server/src/routes/auth.ts
# Change: expiresIn: '7d'
```

#### "Invalid token" error
```bash
# Token might be corrupted
# Clear browser storage:
localStorage.clear()

# Login again
```

#### Logout doesn't work
```bash
# Check browser console for errors
# If still logged in:
# - Clear localStorage manually
# - Press F12 → Console
# - Run: localStorage.clear()
# - Refresh page
```

---

### ❌ Database Issues

#### "SQLITE_READONLY" error
```bash
# Database permissions wrong
# Remove and recreate
rm homelab.db

# Restart server
npm run dev
```

#### Database too large
```bash
# Check size
du -sh homelab.db

# Backup current database
cp homelab.db homelab.db.backup

# Clear old data if needed
# Edit server/src/database.ts for cleanup queries
```

#### Tables missing
```bash
# Manually recreate
rm homelab.db
npm run dev

# Or check server logs during startup
# Should see "CREATE TABLE" messages
```

---

### ❌ Docker Issues

#### Docker not installed
```bash
# Install from https://docs.docker.com/get-docker/
docker --version
docker-compose --version
```

#### docker-compose fails
```bash
# Check syntax
docker-compose config

# Check services
docker-compose ps

# View logs
docker-compose logs -f backend
docker-compose logs -f frontend
```

#### Container port conflicts
```bash
# Edit docker-compose.yml
# Change ports: "5000:5000" to "5001:5000"
```

#### Container won't start
```bash
# Check logs
docker-compose logs backend

# Rebuild
docker-compose build --no-cache

# Restart
docker-compose down
docker-compose up -d
```

---

### ❌ TypeScript Issues

#### Type errors
```bash
# Rebuild TypeScript
cd server
npm run build

cd ../client
npm run build

# Or during dev (should auto-compile)
# Check terminal output for errors
```

#### Missing type definitions
```bash
# Install types
npm install --save-dev @types/node
npm install --save-dev @types/express

cd client
npm install --save-dev @types/react
```

---

### ❌ Performance Issues

#### Slow startup
```bash
# First run creates database - normal
# Subsequent runs are faster

# If still slow:
# Check CPU/RAM usage
# Close background apps
```

#### Slow API responses
```bash
# Check database size
du -sh homelab.db

# Monitor backend logs
# Add indexes if needed

# Check network connection
# ping localhost
```

#### High memory usage
```bash
# Restart services
npm run dev

# Check for memory leaks in code
# Monitor with: top (Linux) or Task Manager (Windows)
```

---

### ✅ Helpful Debug Commands

```bash
# Check all services running
ps aux | grep node

# View network connections
netstat -an | grep 5000
netstat -an | grep 3000

# Check environment
echo $NODE_ENV
cat .env

# View recent logs
tail -f server.log

# Database integrity check
sqlite3 homelab.db ".tables"

# Clear node modules and reinstall
rm -rf node_modules server/node_modules client/node_modules
npm install
```

---

### 🆘 Still Stuck?

1. **Check logs**: Look at terminal output
2. **Browser console**: F12 → Console tab
3. **Network tab**: F12 → Network tab (check API calls)
4. **Documentation**: Read [README.md](README.md)
5. **Restart**: Sometimes everything just needs a restart!

### 📝 Getting Help

When reporting issues, include:
- Error message (full text)
- What you were doing
- Terminal output
- Browser console errors
- Node/npm versions
- Operating system

---

**Remember: Most issues are solved by:**
1. Clearing cache: `npm cache clean --force`
2. Reinstalling: `rm -rf node_modules && npm install`
3. Restarting: Stop and start services again
4. Checking logs: Read all error messages carefully

**Happy debugging!** 🐛✨
