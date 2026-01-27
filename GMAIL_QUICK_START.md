# ⚡ Quick Start: Gmail Email Setup (5 minutes)

## Step-by-Step Guide

### Step 1: Enable 2-Factor Authentication (if not already enabled)
```
Go to: https://myaccount.google.com/security
→ Click "2-Step Verification"
→ Follow prompts (need your phone)
```

### Step 2: Generate Gmail App Password
```
Go to: https://myaccount.google.com/apppasswords
→ Select: Mail + Your Device
→ Google generates 16-character password
→ COPY THE PASSWORD (example: abcd efgh ijkl mnop)
```

### Step 3: Edit .env File
```bash
nano /home/asenic/homelab-ai-code/.env
```

Change these lines:
```
GMAIL_EMAIL=your-email@gmail.com
GMAIL_APP_PASSWORD=abcdefghijklmnop
```

**Important:** Remove spaces from app password! `abcd efgh ijkl mnop` → `abcdefghijklmnop`

Press: `Ctrl+O` → `Enter` → `Ctrl+X` (to save in nano)

### Step 4: Restart Docker Backend
```bash
cd /home/asenic/homelab-ai-code
docker compose -f docker-compose.yml restart backend
```

Wait for it to say: `🚀 Server running at http://localhost:5000`

### Step 5: Test It!
1. Go to: http://localhost:3000/register
2. Register with your Gmail address
3. Check Gmail inbox for verification email

---

## What You'll See

**In Gmail Inbox:**
```
From: noreply@homelab.local
Subject: Verify your Homelab Dashboard email

[Verify Email] button
```

**Click the button** to verify your email ✅

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| "Login failed" error | Check 2FA is enabled, app password copied correctly |
| Email not arriving | Check Gmail spam folder, verify SMTP settings |
| Container won't start | Check .env file has no syntax errors |
| Still using test emails | Make sure EMAIL_SERVICE=smtp in docker-compose.yml |

---

## View Logs
```bash
docker logs homelab-ai-code-backend-1 | tail -30
```

Should show: `📧 Verification email sent to your-email@gmail.com`

---

## Files Modified
- ✅ `docker-compose.yml` - Added Gmail SMTP config
- ✅ `.env` - Created with your Gmail settings
- ✅ `SETUP_GMAIL_EMAIL.md` - Full documentation

---

**That's it! Emails will now be sent to your Gmail inbox! 🎉**
