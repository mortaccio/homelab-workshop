# Email Verification Feature

## Overview

The homelab dashboard now includes email verification to ensure users verify their email addresses during registration. This adds an extra layer of security to prevent spam accounts and ensures valid contact information.

## How It Works

### Registration Flow
1. User registers with username, email, and password
2. System creates a verification token (UUID) with 24-hour expiration
3. Verification email is sent to the user
4. User clicks the verification link from the email
5. Email is confirmed and user can now login

### Login Flow
1. User attempts to login with email and password
2. System checks if email is verified
3. If not verified: Returns 403 "Please verify your email" error
4. If verified: Normal JWT login proceeds

## Configuration

### Development (Using Ethereal Email - Test Service)

Ethereal Email is a free test email service perfect for development:

1. **No configuration needed** - The system automatically creates test credentials on first use
2. Check the backend logs after user registration to find the test email link
3. Open the link in a browser to verify the email

**Backend logs will show:**
```
📧 Email sent to user@example.com
ℹ️  Preview URL: https://ethereal.email/message/xxxxx
```

### Production (Using Real SMTP Server)

#### Gmail Example:
1. Enable 2-factor authentication on your Gmail account
2. Generate an [App Password](https://myaccount.google.com/apppasswords)
3. Set environment variables:
   ```
   EMAIL_SERVICE=smtp
   SMTP_HOST=smtp.gmail.com
   SMTP_PORT=587
   SMTP_USER=your-email@gmail.com
   SMTP_PASS=your-app-password
   EMAIL_FROM=your-email@gmail.com
   BASE_URL=https://your-domain.com
   ```

#### Other Providers:
- **Outlook**: `smtp-mail.outlook.com:587`
- **SendGrid**: `smtp.sendgrid.net:587`
- **Mailgun**: `smtp.mailgun.org:587`

## Testing Email Verification

### Test Scenario:
1. Open http://localhost:3000/register
2. Fill in the registration form with:
   - Username: `testuser`
   - Email: `test@example.com`
   - Password: `TestPassword123`

3. You'll see a confirmation message: "Verification email has been sent to test@example.com"

4. Check backend logs for the test email link:
   ```
   🔗 Verification link: http://localhost:3000/verify-email?token=xxxxx-xxxxx-xxxxx
   ```

5. Click the verification link (or copy-paste it in your browser)

6. You'll see: "Email verified successfully! Redirecting to login..."

7. Try to login - you should now be able to access your account

### Troubleshooting

**"Email already exists" error:**
- The email is already registered
- Use a different email address

**Verification link doesn't work:**
- Token may have expired (24-hour limit)
- Try registering again
- Check that the token in the URL is correct

**Can't receive test emails:**
- Check backend logs for the Ethereal preview URL
- Copy-paste the link directly from logs into your browser
- Ensure you're using the correct token

**Login says "Please verify your email":**
- Your email hasn't been verified yet
- Click the verification link from the email you received
- After verification, you should be able to login

## API Endpoints

### Register
- **POST** `/api/auth/register`
- **Body**: `{ username, email, password }`
- **Response**: Message about verification email
- **Creates**: verification_token and verification_expires

### Verify Email
- **POST** `/api/auth/verify-email`
- **Body**: `{ token }`
- **Response**: JWT token (if valid)
- **Sets**: email_verified = true

### Login
- **POST** `/api/auth/login`
- **Body**: `{ email, password }`
- **Response**: JWT token (if email verified)
- **Error**: 403 if email not verified

## Database Schema

```sql
users table:
- id (TEXT PRIMARY KEY)
- username (TEXT UNIQUE)
- email (TEXT UNIQUE)
- password (TEXT)
- email_verified (BOOLEAN DEFAULT 0)
- verification_token (TEXT)
- verification_expires (DATETIME)
- created_at (DATETIME DEFAULT CURRENT_TIMESTAMP)
```

## Security Features

1. **Token Expiration**: Verification tokens expire after 24 hours
2. **UUID Tokens**: Cryptographically secure random tokens
3. **Email Verification**: Users can't access the dashboard without verifying
4. **Secure Passwords**: Passwords are hashed with bcrypt (10 rounds)
5. **JWT Auth**: Secure token-based authentication

## Future Enhancements

- [x] Email verification on registration
- [ ] Password reset via email
- [ ] Resend verification email endpoint
- [ ] Email change functionality
- [ ] Two-factor authentication (2FA)
- [ ] Email notifications for account activity

## Support

For issues with email configuration:
1. Check that SMTP credentials are correct
2. Ensure the email provider allows SMTP access
3. Verify firewall rules allow outbound SMTP (port 587)
4. Check backend logs: `docker logs homelab-ai-code-backend-1`
