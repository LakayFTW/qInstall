#!/bin/bash

if command -v zsh >/dev/null 2>&1; then
    echo "✅ zsh ist installiert."
else
    echo "❌ zsh ist nicht installiert. Installation wird gestartet..."
    # Beispiel: Installation auf Debian/Ubuntu
    sudo apt update && sudo apt install -y zsh
fi
