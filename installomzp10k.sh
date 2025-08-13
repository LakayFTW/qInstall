#!/bin/bash

# Exit on any error
set -e

# Ensure Zsh is installed
if ! command -v zsh >/dev/null 2>&1; then
    echo "🔄 Installing zsh..."
    if command -v apt >/dev/null 2>&1; then
        sudo apt update && sudo apt install -y zsh git curl
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install -y zsh git curl
    elif command -v brew >/dev/null 2>&1; then
        brew install zsh git curl
    else
        echo "❌ Package manager not detected. Please install zsh manually."
        exit 1
    fi
fi

# Install Oh My Zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "🔄 Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Powerlevel10k theme
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo "🔄 Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi

# Copy custom .zshrc
ZSH_CONFIG_DIR="$HOME/dev/configs/zsh"
ZSHRC_SOURCE="$ZSH_CONFIG_DIR/.zshrc"
ZSHRC_TARGET="$HOME/.zshrc"

if [ -f "$ZSHRC_SOURCE" ]; then
    cp -f "$ZSHRC_SOURCE" "$ZSHRC_TARGET"
    echo "✅ .zshrc copied to $HOME"
else
    echo "❌ $ZSHRC_SOURCE not found. Aborting."
    exit 1
fi

# Set Zsh as default shell
chsh -s "$(command -v zsh)" || echo "⚠️ Could not change default shell, run manually: chsh -s $(command -v zsh)"

# Launch Zsh so user can configure Oh My Zsh / Powerlevel10k
echo "🔄 Starting zsh..."
exec zsh
