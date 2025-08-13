#!/bin/bash

# Zielordner der zsh-Konfiguration
ZSH_CONFIG_DIR="$HOME/dev/configs/zsh"
ZSHRC_SOURCE="$ZSH_CONFIG_DIR/.zshrc"
ZSHRC_TARGET="$HOME/.zshrc"

# Prüfen, ob die Datei existiert
if [ ! -f "$ZSHRC_SOURCE" ]; then
    echo "❌ $ZSHRC_SOURCE existiert nicht!"
    exit 1
fi

# Datei kopieren (überschreiben)
cp -f "$ZSHRC_SOURCE" "$ZSHRC_TARGET"
echo "✅ .zshrc wurde nach $HOME kopiert/überschrieben."

# Zsh neu starten
if command -v zsh >/dev/null 2>&1; then
    echo "🔄 Starte zsh neu..."
    exec zsh
else
    echo "❌ zsh ist nicht installiert!"
fi
