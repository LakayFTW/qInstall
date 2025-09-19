#!/bin/bash
set -e

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

# Prüfen, ob zsh installiert ist
if ! command -v zsh >/dev/null 2>&1; then
    echo "❌ zsh ist nicht installiert!"
    exit 1
fi

# Login-Shell prüfen und ggf. auf zsh ändern
CURRENT_SHELL=$(getent passwd $USER | cut -d: -f7)
ZSH_PATH=$(command -v zsh)
if [ "$CURRENT_SHELL" != "$ZSH_PATH" ]; then
    echo "🔄 Zsh als Standard-Shell setzen..."
    chsh -s "$ZSH_PATH" || echo "⚠️ Konnte Standard-Shell nicht ändern. Bitte manuell ausführen: chsh -s $ZSH_PATH"
else
    echo "✅ Zsh ist bereits die Standard-Shell."
fi

# Zsh starten
echo "🔄 Starte zsh..."
exec zsh
