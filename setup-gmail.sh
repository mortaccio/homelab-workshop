#!/bin/bash

# Gmail Email Setup Script for Homelab Dashboard

echo "📧 Gmail Setup for Homelab Dashboard"
echo "===================================="
echo ""
echo "This script will help you configure Gmail SMTP email."
echo ""

# Check if gmail email is already set
if grep -q "GMAIL_EMAIL" /home/asenic/homelab-ai-code/docker-compose.yml 2>/dev/null; then
    echo "✅ Gmail configuration already in docker-compose.yml"
else
    echo "⚠️  Gmail not yet configured"
fi

echo ""
echo "📋 What you need:"
echo "   1. Gmail account with 2-Factor Authentication enabled"
echo "   2. App Password generated from: https://myaccount.google.com/apppasswords"
echo ""

# Check if .env file exists
if [ ! -f /home/asenic/homelab-ai-code/.env ]; then
    echo "📝 Creating .env file..."
    cp /home/asenic/homelab-ai-code/.env.local /home/asenic/homelab-ai-code/.env
    echo "✅ Created .env file (edit with your Gmail details)"
else
    echo "✅ .env file already exists"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Next steps:"
echo ""
echo "1️⃣  Get your Gmail App Password:"
echo "   • Go to: https://myaccount.google.com/apppasswords"
echo "   • Make sure 2-Factor Auth is enabled"
echo "   • Copy the 16-character password"
echo ""
echo "2️⃣  Edit the .env file:"
echo "   nano /home/asenic/homelab-ai-code/.env"
echo ""
echo "   Replace:"
echo "   - your-email@gmail.com → Your actual Gmail"
echo "   - your-16-character-app-password → Your app password (no spaces)"
echo ""
echo "3️⃣  Restart Docker:"
echo "   docker compose -f docker-compose.yml restart backend"
echo ""
echo "4️⃣  Test registration:"
echo "   • Go to http://localhost:3000/register"
echo "   • Check your Gmail inbox for verification email"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "View logs: docker logs homelab-ai-code-backend-1"
