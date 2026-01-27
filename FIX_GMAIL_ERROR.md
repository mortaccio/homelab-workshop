# 🔧 Gmail Authentication Error - Fix Guide

## ❌ Error You're Seeing
```
Error: Invalid login: 535-5.7.8 Username and Password not accepted
```

This means Gmail is rejecting your credentials.

---

## ✅ Fix: Get Real Gmail Credentials

### Step 1: Check if 2-Factor Auth is Enabled
Go to: https://myaccount.google.com/security

**Look for "2-Step Verification"** - It should say "Status: ON"

If it says "OFF":
1. Click "2-Step Verification"
2. Follow the prompts
3. Use your phone to verify
4. Come back to this guide

---

### Step 2: Generate App Password
1. Go to: https://myaccount.google.com/apppasswords
2. If you see a message about needing to update security settings, do that first
3. **Select:**
   - App: **Mail**
   - Device: **Windows Computer** (or your device type)
4. Click **Generate**
5. Google will show a 16-character password
6. **COPY THIS EXACTLY** (including spaces or without, see Step 3)

**Example:**
```
abcd efgh ijkl mnop
```

---

### Step 3: Update .env File
Open your .env file:
```bash
nano /home/asenic/homelab-ai-code/.env
```

Find these lines:
```
GMAIL_EMAIL=your-email@gmail.com
GMAIL_APP_PASSWORD=your-16-character-app-password
```

Replace with YOUR actual values:
```
GMAIL_EMAIL=your-actual-email@gmail.com
GMAIL_APP_PASSWORD=abcdefghijklmnop
```

**IMPORTANT:** Remove any spaces from the app password!
- ❌ Don't use: `abcd efgh ijkl mnop`
- ✅ Do use: `abcdefghijklmnop`

Save file:
- Press: `Ctrl+O` (WriteOut)
- Press: `Enter`
- Press: `Ctrl+X` (Exit)

---

### Step 4: Verify Docker Can Read .env

Check what Docker will use:
```bash
docker exec homelab-ai-code-backend-1 env | grep -E "GMAIL|SMTP_"
```

Should show:
```
GMAIL_EMAIL=your-actual-email@gmail.com
GMAIL_APP_PASSWORD=abcdefghijklmnop
SMTP_USER=your-actual-email@gmail.com
SMTP_PASS=abcdefghijklmnop
```

If it still shows placeholder values, Docker didn't reload the .env file yet.

---

### Step 5: Restart Backend
```bash
cd /home/asenic/homelab-ai-code
docker compose -f docker-compose.yml restart backend
```

Wait for: `🚀 Server running at http://localhost:5000`

---

### Step 6: Test Again
1. Go to: http://localhost:3000/register
2. Register with your Gmail address
3. Check backend logs:
   ```bash
   docker logs homelab-ai-code-backend-1 | tail -20
   ```
4. Should show: `📧 Verification email sent to your-email@gmail.com`
5. Check Gmail inbox for verification email

---

## 🆘 Still Not Working?

### Check 1: Is 2-Factor Auth Enabled?
```
https://myaccount.google.com/security
→ Look for "2-Step Verification"
→ Should say: Status ON
```

If OFF, enable it first!

### Check 2: Is .env Updated?
```bash
# Should show YOUR actual Gmail
cat /home/asenic/homelab-ai-code/.env | grep GMAIL
```

### Check 3: Restart Docker
```bash
docker compose -f docker-compose.yml down
docker compose -f docker-compose.yml up -d
docker logs -f homelab-ai-code-backend-1
```

Then try registering and watch the logs.

### Check 4: Gmail Rejected the Password?
If you still see the same error, your app password might be wrong.

Go back to: https://myaccount.google.com/apppasswords
- Delete the old password
- Generate a new one
- Copy it exactly (no spaces)
- Update .env again
- Restart Docker

---

## 📝 Common Mistakes

| Mistake | Fix |
|---------|-----|
| Spaces in password | Remove them: `abcd efgh` → `abcdefgh` |
| Wrong email address | Use your full Gmail (e.g., `john@gmail.com`) |
| 2FA not enabled | Enable at: https://myaccount.google.com/security |
| Old app password | Generate new one at apppasswords page |
| Docker not restarted | Run: `docker compose restart backend` |
| .env not updated | Edit with: `nano /home/asenic/homelab-ai-code/.env` |

---

## ✅ Checklist

Before testing again:
- [ ] 2-Factor Authentication is ON (https://myaccount.google.com/security)
- [ ] App password generated (https://myaccount.google.com/apppasswords)
- [ ] .env file updated with correct email
- [ ] .env file updated with correct app password (NO SPACES)
- [ ] Backend restarted: `docker compose restart backend`
- [ ] Logs show: `🚀 Server running at http://localhost:5000`

---

## 🎯 Quick Command to Fix

If you have your app password ready:
```bash
# Open .env in nano editor
nano /home/asenic/homelab-ai-code/.env

# Make these changes:
# Line 12: GMAIL_EMAIL=your-actual-email@gmail.com
# Line 13: GMAIL_APP_PASSWORD=your-app-password

# Save: Ctrl+O → Enter → Ctrl+X

# Restart Docker
docker compose -f docker-compose.yml restart backend

# Test
curl -X POST http://localhost:5000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"username":"test","email":"your-email@gmail.com","password":"Test123!"}'
```

---

## Still Stuck?

Gmail error code: **535-5.7.8**

This means Google rejected your credentials. Most common causes:
1. **2FA not enabled** - Check https://myaccount.google.com/security
2. **Wrong app password** - Generate new one and copy exactly
3. **Spaces in password** - Remove all spaces
4. **Gmail account locked** - Check for suspicious activity notices
5. **App password expired** - Generate new one

Check Google's help: https://support.google.com/mail/?p=BadCredentials

---

**Once credentials are correct, emails will work perfectly!** ✅
