#!/bin/bash

echo "🚀 Starting Installation for SIMIN AI Assistant..."

# Update package lists
echo "🔄 Updating package lists..."
sudo apt update -y && sudo apt upgrade -y

# Install Ruby if not installed
if ! command -v ruby &> /dev/null; then
    echo "🛠 Installing Ruby..."
    sudo apt install ruby-full -y
fi

# Install Bundler
echo "📦 Installing Bundler..."
gem install bundler

# Install required Ruby gems
echo "📦 Installing Dependencies..."
gem install faraday httparty json awesome_print cli-ui tty-box highline

echo "✅ Installation Complete! You can now run:"
echo "👉 ruby simin-ai-assistant.rb"
