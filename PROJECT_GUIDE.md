# 🏠 Homelab Dashboard - Project Overview

## 📊 Project Architecture

```
┌─────────────────────────────────────────────────────────┐
│                      Browser                             │
│                  http://localhost:3000                   │
└─────────────────────────────────────────────────────────┘
                            ↑↓
┌─────────────────────────────────────────────────────────┐
│              React Frontend (TypeScript)                │
│  ├─ Pages: Login, Register, Dashboard                  │
│  ├─ Components: ServiceCard, ServiceForm                │
│  ├─ Context: Authentication state                      │
│  └─ API Client: Axios integration                      │
└─────────────────────────────────────────────────────────┘
                            ↑↓
                   HTTP REST API
                  :5000/api/*
                            ↑↓
┌─────────────────────────────────────────────────────────┐
│            Node.js/Express Backend (TypeScript)         │
│  ├─ Routes:                                             │
│  │  ├─ /api/auth - Authentication                      │
│  │  ├─ /api/services - Service management              │
│  │  └─ /api/share - Sharing functionality              │
│  ├─ Database: SQLite                                   │
│  └─ Security: JWT + Bcrypt                             │
└─────────────────────────────────────────────────────────┘
                            ↑↓
┌─────────────────────────────────────────────────────────┐
│                    SQLite Database                       │
│  ├─ users table                                         │
│  ├─ services table                                      │
│  └─ shared_access table                                │
└─────────────────────────────────────────────────────────┘
```

## 📁 File Structure

```
homelab-ai-code/
│
├── 📄 Core Files
│   ├── package.json              Root npm config
│   ├── README.md                 Full documentation
│   ├── GETTING_STARTED.md        Quick start guide
│   ├── .env.example              Environment template
│   └── setup.sh                  Auto-setup script
│
├── 🐳 Docker & Deployment
│   ├── docker-compose.yml        Compose configuration
│   ├── Dockerfile.server         Backend container
│   ├── Dockerfile.client         Frontend container
│   └── nginx.conf                Web server config
│
├── 📂 server/ (Backend)
│   ├── package.json
│   ├── tsconfig.json
│   └── src/
│       ├── index.ts              Main server file
│       ├── database.ts           DB initialization
│       └── routes/
│           ├── auth.ts           Register/Login
│           ├── services.ts       CRUD endpoints
│           └── share.ts          Sharing system
│
├── 📂 client/ (Frontend)
│   ├── package.json
│   ├── vite.config.ts            Build config
│   ├── tsconfig.json
│   ├── index.html                Entry HTML
│   └── src/
│       ├── main.tsx              Entry point
│       ├── App.tsx               Root component
│       ├── api.ts                API client
│       ├── pages/
│       │   ├── Login.tsx
│       │   ├── Register.tsx
│       │   └── Dashboard.tsx
│       ├── components/
│       │   ├── ProtectedRoute.tsx
│       │   ├── ServiceCard.tsx
│       │   └── ServiceForm.tsx
│       ├── context/
│       │   └── AuthContext.tsx    Auth state
│       └── styles/
│           ├── index.css
│           ├── Auth.css
│           ├── Dashboard.css
│           ├── ServiceCard.css
│           └── ServiceForm.css
│
└── 📂 .github/
    └── copilot-instructions.md
```

## 🔄 Data Flow

### User Registration Flow
```
1. User fills registration form
2. POST /api/auth/register
3. Backend hashes password with bcrypt
4. User created in database
5. JWT token generated
6. Frontend stores token + user info
7. Redirect to dashboard
```

### Adding a Service Flow
```
1. User clicks "+ Add Service"
2. Fills: name, URL, description, category
3. POST /api/services (with JWT)
4. Backend verifies token, creates service
5. Service stored in database
6. Frontend refreshes service list
7. New service appears in grid
```

### Sharing a Service Flow
```
1. User clicks 👥 on service
2. Enters friend's email
3. POST /api/share
4. Backend creates shared_access record
5. Friend sees service in "Shared with Me"
6. Friend can open service
7. Cannot edit/delete friend's services
```

## 🔐 Security Features

- **Authentication**: JWT tokens (7-day expiry)
- **Password**: Bcrypt hashing (10 salt rounds)
- **Protected Routes**: React Router guards
- **API Protection**: Token verification middleware
- **CORS**: Enabled for cross-origin requests
- **Data Isolation**: Users can only access own services

## 📦 Dependencies

### Backend
- express, cors, dotenv
- sqlite3, uuid, bcrypt, jsonwebtoken
- typescript, tsx (dev)

### Frontend
- react, react-dom, react-router-dom
- axios (HTTP client)
- vite (bundler), typescript (dev)

## 🚀 Development Workflow

```bash
npm run dev              # Start both servers
# Opens:
# - Backend: http://localhost:5000
# - Frontend: http://localhost:3000
```

Backend watches: `src/**/*.ts`
Frontend watches: `src/**/*.tsx` + `styles/**/*.css`

Changes auto-refresh in browser!

## 🐳 Docker Workflow

```bash
docker-compose up -d    # Start containers
docker-compose down     # Stop containers
docker-compose logs -f  # View logs
```

## 🧪 Testing

1. **Register** - Create new account
2. **Login** - Verify authentication
3. **Add Service** - Test service creation
4. **Share** - Share with another user
5. **Access** - View shared services

## 📈 Scalability

Current setup uses SQLite which is perfect for:
- Single-user deployments
- Small homelab scenarios
- Development/testing

For enterprise scale, upgrade to:
- PostgreSQL
- MongoDB
- MySQL

Update `database.ts` connection to migrate databases.

## 🎨 Customization

### Colors
Edit `client/src/styles/*.css`:
- Primary: `#667eea`
- Secondary: `#764ba2`
- Background: `linear-gradient(135deg, #667eea 0%, #764ba2 100%)`

### Adding More Service Fields
1. Update database schema in `server/src/database.ts`
2. Add fields to API in `routes/services.ts`
3. Update frontend form `ServiceForm.tsx`
4. Add to database migration if needed

### Branding
- Change app name in `index.html` title
- Update header in `Dashboard.tsx`
- Customize colors in CSS files

## 🐛 Debug Mode

```bash
# Backend debug
DEBUG=* npm run server:dev

# Frontend (already has source maps in vite)
npm run client:dev
```

## 📊 Database Schema

```sql
-- Users
CREATE TABLE users (
  id TEXT PRIMARY KEY,
  username TEXT UNIQUE NOT NULL,
  email TEXT UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Services
CREATE TABLE services (
  id TEXT PRIMARY KEY,
  owner_id TEXT NOT NULL,
  name TEXT NOT NULL,
  description TEXT,
  url TEXT NOT NULL,
  icon TEXT,
  category TEXT,
  is_public BOOLEAN DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (owner_id) REFERENCES users(id)
);

-- Shared Access
CREATE TABLE shared_access (
  id TEXT PRIMARY KEY,
  service_id TEXT NOT NULL,
  shared_with_email TEXT NOT NULL,
  created_by TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (service_id) REFERENCES services(id),
  FOREIGN KEY (created_by) REFERENCES users(id)
);
```

## 🚀 Deployment Checklist

- [ ] Update JWT_SECRET in .env
- [ ] Enable HTTPS with reverse proxy
- [ ] Set NODE_ENV=production
- [ ] Configure CORS properly
- [ ] Set up automated backups
- [ ] Configure logging
- [ ] Add rate limiting
- [ ] Test with real domain
- [ ] Set up monitoring

---

**Ready to launch your homelab!** 🚀
