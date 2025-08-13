#!/bin/bash

# Bash-Skript zum Klonen eines GitHub-Repositories

REPO_URL="https://github.com/LakayFTW/configs.git"
TARGET_DIR="../configs/"

if [ -z "$REPO_URL" ]; then
    echo "Fehler: Keine URL angegeben."
    exit 1
fi

if [ -z "$TARGET_DIR" ]; then
    git clone "$REPO_URL"
else
    git clone "$REPO_URL" "$TARGET_DIR"
fi

if [ $? -eq 0 ]; then
    echo "Repository erfolgreich geklont."
else
    echo "Fehler beim Klonen des Repositories."
fi


if command -v zsh >/dev/null 2>&1; then
    echo "✅ zsh ist installiert."
else
    echo "❌ zsh ist nicht installiert. Installation wird gestartet..."
    # Beispiel: Installation auf Debian/Ubuntu
    sudo apt update && sudo apt install -y zsh
fi

./checkzsh.sh

./installzsh.sh

./installomzp10k.sh