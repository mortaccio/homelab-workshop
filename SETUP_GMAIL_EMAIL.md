# How to Set Up Gmail Email Delivery

## Step 1: Enable 2-Factor Authentication on Gmail

1. Go to https://myaccount.google.com/security
2. In the left sidebar, click **"2-Step Verification"**
3. Follow the prompts to enable 2FA
4. You'll need your phone to verify

## Step 2: Generate Gmail App Password

1. After enabling 2FA, go to https://myaccount.google.com/apppasswords
2. Select:
   - **App**: Mail
   - **Device**: Windows Computer (or whatever you use)
3. Google will generate a 16-character password
4. **COPY THIS PASSWORD** (you'll need it next)

**Example App Password:** `abcd efgh ijkl mnop` (remove spaces when using)

## Step 3: Update Environment Variables

Edit your `docker-compose.yml` and add/update the backend environment section:

```yaml
services:
  backend:
    environment:
      # ... existing vars ...
      EMAIL_SERVICE: smtp
      SMTP_HOST: smtp.gmail.com
      SMTP_PORT: 587
      SMTP_USER: your-email@gmail.com
      SMTP_PASS: abcdefghijklmnop
      EMAIL_FROM: your-email@gmail.com
      BASE_URL: http://localhost:3000
```

**Replace:**
- `your-email@gmail.com` - Your actual Gmail address
- `abcdefghijklmnop` - Your 16-character app password (no spaces)

## Step 4: Restart Docker Container

```bash
cd /home/asenic/homelab-ai-code
docker compose -f docker-compose.yml restart backend
```

## Step 5: Test Email Sending

1. Go to http://localhost:3000/register
2. Register with your email address
3. Check your Gmail inbox for the verification email
4. You should see an email from `noreply@homelab.local`

## Step 6: View Backend Logs (Confirmation)

```bash
docker logs homelab-ai-code-backend-1 | grep -i "email sent"
```

You should see: `📧 Verification email sent to your-email@gmail.com`

---

## 📧 Email Will Now Come From

- **From:** noreply@homelab.local
- **To:** Your Gmail inbox
- **Real email** from your backend server

## ✅ Gmail Security Notes

- App passwords only work with 2-factor authentication enabled
- Each app password can only be used by one application
- You can create multiple app passwords for different apps
- App passwords are just like your regular password - keep it secret!
- If you lose it, just generate a new one

## 🚨 Common Issues

**"Invalid login" error:**
- Check that 2FA is enabled
- Verify you copied the app password correctly (remove spaces)
- Make sure SMTP_USER is your full Gmail address

**"Email still not arriving:**
- Check Gmail spam folder
- Check backend logs: `docker logs homelab-ai-code-backend-1`
- Verify SMTP credentials in docker-compose.yml

**Container won't start:**
- Check for typos in SMTP settings
- Verify special characters are properly quoted
- Restart: `docker compose restart backend`

## 📝 Example docker-compose.yml Section

```yaml
services:
  backend:
    build:
      context: .
      dockerfile: Dockerfile.server
    container_name: homelab-ai-code-backend-1
    ports:
      - "5000:5000"
    environment:
      NODE_ENV: production
      PORT: 5000
      JWT_SECRET: your-secret-key-change-this
      DATABASE_URL: ./homelab.db
      EMAIL_SERVICE: smtp
      SMTP_HOST: smtp.gmail.com
      SMTP_PORT: 587
      SMTP_USER: myemail@gmail.com
      SMTP_PASS: abcd efgh ijkl mnop
      EMAIL_FROM: myemail@gmail.com
      BASE_URL: http://localhost:3000
    networks:
      - homelab
```

---

## Alternative Email Providers

If you don't want to use Gmail:

### Outlook/Hotmail
```
SMTP_HOST: smtp-mail.outlook.com
SMTP_PORT: 587
SMTP_USER: your-email@outlook.com
SMTP_PASS: your-password
```

### SendGrid
```
SMTP_HOST: smtp.sendgrid.net
SMTP_PORT: 587
SMTP_USER: apikey
SMTP_PASS: SG.xxxxxxxxxxxxx
```

### Mailgun
```
SMTP_HOST: smtp.mailgun.org
SMTP_PORT: 587
SMTP_USER: your-mailgun-email
SMTP_PASS: your-mailgun-password
```

---

## Need Help?

1. Check docker logs: `docker logs homelab-ai-code-backend-1`
2. Verify Gmail settings: https://myaccount.google.com/apppasswords
3. Test SMTP connection: `telnet smtp.gmail.com 587`
