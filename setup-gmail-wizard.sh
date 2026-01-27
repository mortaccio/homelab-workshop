#!/bin/bash

echo "📧 Gmail Setup Wizard"
echo "===================="
echo ""
echo "This will help you fix the Gmail authentication error."
echo ""
echo "⚠️  REQUIRED: 2-Factor Authentication must be enabled"
echo ""
read -p "Have you enabled 2-Factor Auth on Gmail? (y/n): " has_2fa

if [ "$has_2fa" != "y" ]; then
    echo ""
    echo "❌ 2-Factor Auth is required!"
    echo "Go to: https://myaccount.google.com/security"
    echo "Enable '2-Step Verification', then run this script again."
    exit 1
fi

echo ""
echo "✅ Great! Now let's get your App Password"
echo ""
echo "Go to: https://myaccount.google.com/apppasswords"
echo ""
read -p "Enter your Gmail email: " gmail_email
read -sp "Enter your 16-character App Password (no spaces): " app_password

echo ""
echo ""

# Validate inputs
if [ -z "$gmail_email" ] || [ -z "$app_password" ]; then
    echo "❌ Email and password are required!"
    exit 1
fi

if [ ${#app_password} -ne 16 ]; then
    echo "⚠️  App password should be 16 characters"
    echo "Current length: ${#app_password}"
    read -p "Continue anyway? (y/n): " continue_anyway
    if [ "$continue_anyway" != "y" ]; then
        exit 1
    fi
fi

echo ""
echo "Updating .env file..."

# Update .env file
sed -i "s|GMAIL_EMAIL=.*|GMAIL_EMAIL=$gmail_email|" /home/asenic/homelab-ai-code/.env
sed -i "s|GMAIL_APP_PASSWORD=.*|GMAIL_APP_PASSWORD=$app_password|" /home/asenic/homelab-ai-code/.env

echo "✅ .env file updated"
echo ""

# Show what was updated
echo "Verification:"
echo ""
echo "Email: $(grep GMAIL_EMAIL /home/asenic/homelab-ai-code/.env)"
echo "Password: $(grep GMAIL_APP_PASSWORD /home/asenic/homelab-ai-code/.env | sed 's/=.*/=***HIDDEN***/g')"
echo ""

read -p "Does this look correct? (y/n): " is_correct

if [ "$is_correct" != "y" ]; then
    echo "❌ Not updating Docker. Edit manually:"
    echo "nano /home/asenic/homelab-ai-code/.env"
    exit 1
fi

echo ""
echo "🔄 Restarting Docker backend..."
cd /home/asenic/homelab-ai-code

docker compose -f docker-compose.yml restart backend

echo ""
echo "⏳ Waiting for backend to start..."
sleep 5

echo ""
echo "✅ Backend restarted!"
echo ""
echo "Check logs:"
echo "docker logs homelab-ai-code-backend-1 | tail -10"
echo ""
echo "Now try registering at: http://localhost:3000/register"
echo ""
