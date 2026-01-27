# 🚀 Getting Started Guide

## Installation & Setup

### 1️⃣ Prerequisites
- **Node.js 16+**: Download from [nodejs.org](https://nodejs.org)
- **npm** (comes with Node.js)
- Optional: Docker & Docker Compose for containerized deployment

### 2️⃣ Quick Start (Development)

```bash
# Navigate to project
cd /home/asenic/homelab-ai-code

# Run setup script (auto-installs dependencies)
chmod +x setup.sh
./setup.sh

# Start development servers
npm run dev
```

**Access:**
- Frontend: http://localhost:3000
- Backend API: http://localhost:5000

### 3️⃣ Manual Setup

```bash
cd /home/asenic/homelab-ai-code

# Install root dependencies
npm install

# Install backend
cd server && npm install && cd ..

# Install frontend
cd client && npm install && cd ..

# Copy environment
cp .env.example .env

# Start dev
npm run dev
```

## 🎯 First Time Users

1. **Open** http://localhost:3000
2. **Register** - Create a new account
3. **Login** - Use your credentials
4. **Add Services** - Click "+ Add Service" and fill:
   - Name: Any name (e.g., "Pi-hole")
   - URL: Service address (e.g., http://192.168.1.100:80)
   - Description: What it does
   - Category: Type of service
5. **Share** - Click 👥 button and enter friend's email
6. **Access Shared** - Check "Shared with Me" tab

## 📦 Building for Production

```bash
# Build both frontend and backend
npm run build

# Outputs:
# - server/dist/     (compiled backend)
# - client/dist/     (compiled frontend)
```

## 🐳 Docker Deployment

```bash
# Start with Docker Compose
docker-compose up -d

# Stop
docker-compose down

# Access:
# - Frontend: http://localhost:3000
# - Backend: http://localhost:5000
```

## 🔧 Environment Variables

Create `.env` file:

```bash
PORT=5000
NODE_ENV=development
JWT_SECRET=your-secret-key-change-in-production
```

⚠️ **For production**, generate a strong JWT_SECRET:
```bash
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
```

## 📁 Project Structure

```
homelab-ai-code/
├── server/              Backend (Node.js + TypeScript)
│   ├── src/
│   │   ├── index.ts
│   │   ├── database.ts
│   │   └── routes/
│   └── package.json
├── client/              Frontend (React + TypeScript)
│   ├── src/
│   │   ├── pages/
│   │   ├── components/
│   │   └── styles/
│   └── package.json
├── README.md
├── docker-compose.yml
└── .env.example
```

## 🚨 Common Issues

### "Cannot find module"
```bash
# Reinstall dependencies
rm -rf node_modules server/node_modules client/node_modules
npm install
cd server && npm install && cd ..
cd client && npm install && cd ..
```

### Port already in use
- **Backend port 5000**: Edit `.env` → change `PORT`
- **Frontend port 3000**: Edit `client/vite.config.ts` → change `port`

### Database error
```bash
# Reset database
rm homelab.db
npm run dev  # Will recreate on startup
```

### TypeScript errors
```bash
# Rebuild TypeScript
cd server && npm run build
cd ../client && npm run build
```

## 📋 Available Commands

```bash
# Development
npm run dev              # Start both servers
npm run server:dev       # Backend only
npm run client:dev       # Frontend only

# Building
npm run build            # Build all
npm run server:build     # Build backend
npm run client:build     # Build frontend

# Docker
npm run docker:up        # Start containers
npm run docker:down      # Stop containers
```

## 🔐 Security Tips

1. **Change JWT_SECRET** before production
2. **Use HTTPS** with reverse proxy (nginx/Traefik)
3. **Enable authentication** for your services
4. **Whitelist IPs** if accessing remotely
5. **Regular backups** of homelab.db

## 📚 API Documentation

See [README.md](README.md) for full API endpoints.

## 🆘 Need Help?

- Check [README.md](README.md) for detailed info
- Review [server logs](server/src) for backend issues
- Browser console (F12) for frontend errors
- Check `.env` configuration

## ✨ What's Next?

- ✅ Add your services
- ✅ Share with friends
- ✅ Customize categories
- ✅ Deploy to production
- ✅ Add more features!

---

**Happy homelabbing!** 🏠✨
