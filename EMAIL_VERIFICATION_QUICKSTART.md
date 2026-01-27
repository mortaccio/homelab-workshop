# Email Verification - Quick Start Guide

## 🚀 Quick Test (2 minutes)

### Step 1: Open the App
Go to: **http://localhost:3000**

### Step 2: Register (No verification yet)
1. Click "Register" if you see a login page
2. Fill in form:
   - Username: `testuser`
   - Email: `test@example.com`
   - Password: `Password123`
   - Confirm: `Password123`
3. Click "Register"
4. **See message**: "Verification email has been sent to test@example.com"

### Step 3: Get Verification Link
1. Open terminal and run:
   ```bash
   docker logs homelab-ai-code-backend-1 | grep -A10 "VERIFICATION EMAIL SENT"
   ```
2. **Look for output like this**:
   ```
   📧 VERIFICATION EMAIL SENT
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   To: test@example.com
   Username: testuser

   🔗 VERIFICATION LINK:
   http://localhost:3000/verify-email?token=550e8400-e29b-41d4-a716-446655440000

   👁️  VIEW EMAIL (Ethereal Test):
   https://ethereal.email/message/xxxxx
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   ```
3. **Copy the verification link** (the one starting with `http://localhost:3000/verify-email?token=...`)

### Step 4: Verify Email
1. **Paste the link** in your browser address bar and press Enter
2. **See success page**: "Email verified successfully! Redirecting to login..."
3. **Auto-redirect** to login page

### Step 5: Login
1. Email: `test@example.com`
2. Password: `Password123`
3. Click "Login"
4. **✅ Success!** You're now logged into the dashboard

---

## 🧪 Advanced Test (Unverified User)

### Try to Login Before Verification
1. Register another account: `test2@example.com`
2. **DO NOT click the verification link**
3. Go to http://localhost:3000/login
4. Try to login with `test2@example.com` and password
5. **See error**: "Please verify your email"
6. This proves email verification is working!

---

## 📧 Where to Find Test Emails

### For Development (Ethereal Email - Default)

The backend automatically creates test accounts. Emails appear in console logs:

**Check backend logs immediately after registration:**
```bash
docker logs homelab-ai-code-backend-1 | grep -A10 "VERIFICATION EMAIL SENT"
```

**You'll see a clear formatted output:**
```
📧 VERIFICATION EMAIL SENT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
To: test@example.com
Username: testuser

🔗 VERIFICATION LINK:
http://localhost:3000/verify-email?token=xxxxx

👁️  VIEW EMAIL (Ethereal Test):
https://ethereal.email/message/xxxxx
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Copy the verification link** and paste it directly into your browser address bar.

### For Production (Real Email)

Set these environment variables in your `docker-compose.yml`:
```yml
environment:
  EMAIL_SERVICE: smtp
  SMTP_HOST: smtp.gmail.com
  SMTP_PORT: 587
  SMTP_USER: your-email@gmail.com
  SMTP_PASS: your-app-password
  BASE_URL: https://your-domain.com
```

Then restart: `docker compose restart backend`

---

## 🐛 Troubleshooting

### "Cannot find verification link in logs"
```bash
# Get the latest logs with clear formatting
docker logs homelab-ai-code-backend-1 | tail -100 | grep -A10 "VERIFICATION EMAIL SENT"

# Or watch logs in real-time while registering in another terminal
docker logs -f homelab-ai-code-backend-1
# Then register a new account - you'll see the link appear immediately
```

**The output should clearly show:**
- ✅ `To: your-email@example.com`
- ✅ `🔗 VERIFICATION LINK: http://localhost:3000/verify-email?token=...`
- ✅ `👁️  VIEW EMAIL (Ethereal Test): https://ethereal.email/message/...`

### "Verification link doesn't work / says invalid"
- Token may have expired (24-hour limit)
- Register again and get a new token
- Check that you have the complete URL with `?token=...`

### "Can't login - says 'Please verify your email'"
- You haven't clicked the verification link yet
- Get the verification link from logs (see above)
- Click it in your browser

### "Registration page not showing"
- Go directly to http://localhost:3000/register
- Or click "Register here" link on login page

### "Backend container crashed"
```bash
docker logs homelab-ai-code-backend-1
# Check for error messages
```

### Restart everything
```bash
cd /home/asenic/homelab-ai-code
docker compose -f docker-compose.yml -f docker-compose.services.yml down
docker compose -f docker-compose.yml -f docker-compose.services.yml up -d
```

---

## 📊 System Status

**Check if everything is running:**
```bash
docker compose -f docker-compose.yml -f docker-compose.services.yml ps
```

**You should see:**
- `homelab-ai-code-backend-1` - Up
- `homelab-ai-code-frontend-1` - Up
- Various service containers (jellyfin, nextcloud, etc.)

---

## 🎯 What's Actually Happening

When you register:
1. ✅ Form submitted to backend
2. ✅ Backend generates random verification token
3. ✅ Token saved to database with 24-hour expiration
4. ✅ Email created and sent via Ethereal Email
5. ✅ Link in email contains the token
6. ✅ Preview/link shown in backend logs

When you click the verification link:
1. ✅ Browser goes to `/verify-email?token=xxxxx`
2. ✅ Frontend sends token to backend
3. ✅ Backend verifies token is valid and not expired
4. ✅ Backend marks email as verified in database
5. ✅ Backend returns JWT login token
6. ✅ Frontend redirects to login page
7. ✅ You can now login

---

## 📚 More Information

For complete documentation, see:
- [EMAIL_VERIFICATION.md](./EMAIL_VERIFICATION.md) - Full technical details
- [README.md](./README.md) - Project overview
- [GETTING_STARTED.md](./GETTING_STARTED.md) - Setup instructions

---

## ✨ You're All Set!

The email verification system is ready to test. Go to http://localhost:3000 and try registering!

**Happy testing! 🎉**
