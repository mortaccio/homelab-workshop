# 🚀 Fresh Start - Clean Database

## ✅ What Was Cleared

- ✅ All previous user accounts deleted
- ✅ Database reset to empty state
- ✅ Containers restarted with fresh database
- ✅ Backend and frontend running and ready

---

## 📊 Current System Status

### Containers Running
```
✅ homelab-ai-code-backend-1  - Port 5000 (API)
✅ homelab-ai-code-frontend-1 - Port 3000 (Web UI)
✅ 9 Example services (Jellyfin, Nextcloud, Vaultwarden, etc.)
```

### Database Status
```
📦 FRESH EMPTY DATABASE
🆕 No users registered yet
🆕 No services configured yet
🆕 Ready for testing
```

---

## 🧪 Test Email Verification System

### Option 1: Test with Gmail (Real Email)

Make sure your `.env` file is configured:
```bash
# View current Gmail settings
cat /home/asenic/homelab-ai-code/.env | grep GMAIL
```

**Should show:**
```
GMAIL_EMAIL=your-email@gmail.com
GMAIL_APP_PASSWORD=your-16-char-password
```

If not set, run:
```bash
nano /home/asenic/homelab-ai-code/.env
# Update GMAIL_EMAIL and GMAIL_APP_PASSWORD
# Save: Ctrl+O → Enter → Ctrl+X

docker compose -f docker-compose.yml restart backend
```

### Option 2: Test with Ethereal (Test Emails in Logs)

Default mode - emails show in backend logs:
```bash
docker logs homelab-ai-code-backend-1 | grep -A5 "VERIFICATION LINK"
```

---

## 📝 Step-by-Step Test

### 1. Open Dashboard
```
http://localhost:3000
```

### 2. Click "Register"
Fill in:
- **Username:** `testuser`
- **Email:** `your-email@gmail.com` (if using Gmail)
- **Password:** `TestPassword123`
- **Confirm:** `TestPassword123`

### 3. Submit Registration
Click "Register" button

### 4a. Gmail Users
- Check your Gmail inbox
- Look for email from `noreply@homelab.local`
- Click verification link in email
- See "Email verified successfully!"
- Can now login

### 4b. Ethereal Users (Test Mode)
- Check backend logs: `docker logs homelab-ai-code-backend-1 | tail -20`
- Look for: `🔗 VERIFICATION LINK:`
- Copy the link
- Paste in browser
- See "Email verified successfully!"
- Can now login

### 5. Login
- Email: `your-email@gmail.com` (or test email)
- Password: `TestPassword123`
- Should now access dashboard

---

## 🔐 Verify Email Verification is Working

**Test unverified login:**
1. Register new account with `test2@example.com`
2. DON'T click verification link
3. Try to login
4. Should see: **"Please verify your email"** error ✅

This proves email verification is enforced!

---

## 📊 Database is Completely Clean

Check with:
```bash
# Verify database exists and is empty
docker exec homelab-ai-code-backend-1 sqlite3 homelab.db ".tables"

# Should show: users services shared_access
# But no data in any of them
```

---

## 🎯 What to Test

- [ ] Register with email
- [ ] Receive verification email (Gmail or logs)
- [ ] Click verification link
- [ ] Successfully login
- [ ] Try unverified login (should fail)
- [ ] Add services from dashboard
- [ ] Share services with friends (if available)
- [ ] Access example services (Jellyfin, Nextcloud, etc.)

---

## 📞 Quick Commands

```bash
# View backend logs
docker logs homelab-ai-code-backend-1

# Watch logs in real-time
docker logs -f homelab-ai-code-backend-1

# Check database
docker exec homelab-ai-code-backend-1 sqlite3 homelab.db "SELECT * FROM users;"

# View Gmail settings
cat /home/asenic/homelab-ai-code/.env | grep GMAIL

# Restart backend (if config changes)
docker compose -f docker-compose.yml restart backend

# View all running services
docker ps
```

---

## 🎉 Ready to Test!

All user data has been cleared. Fresh, clean database is ready for testing.

**Start here:** http://localhost:3000

Good luck! Let me know if you need any help. 🚀
