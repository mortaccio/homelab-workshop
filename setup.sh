#!/bin/bash

# Homelab Dashboard - Setup Script
set -e

echo "🏠 Homelab Dashboard - Setup"
echo "=============================="

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js 16 or higher."
    echo "Visit: https://nodejs.org/"
    exit 1
fi

echo "✓ Node.js version: $(node --version)"
echo "✓ npm version: $(npm --version)"

# Install root dependencies
echo ""
echo "📦 Installing root dependencies..."
npm install

# Install server dependencies
echo ""
echo "📦 Installing server dependencies..."
cd server
npm install
cd ..

# Install client dependencies
echo ""
echo "📦 Installing client dependencies..."
cd client
npm install
cd ..

# Copy environment file
if [ ! -f .env ]; then
    echo ""
    echo "⚙️  Creating .env file from .env.example..."
    cp .env.example .env
    echo "✓ .env created - Update JWT_SECRET in production!"
fi

echo ""
echo "=============================="
echo "✅ Setup Complete!"
echo ""
echo "🚀 To start development:"
echo "   npm run dev"
echo ""
echo "📚 For more info, see README.md"
