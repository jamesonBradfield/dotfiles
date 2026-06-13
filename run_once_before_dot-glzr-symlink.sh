#!/bin/bash
# chezmoi run_once_before script: ensures ~/.glzr symlinks to Windows side
# Only applies inside WSL

if ! grep -qi WSL /proc/sys/kernel/osrelease 2>/dev/null && ! grep -qi microsoft /proc/version 2>/dev/null; then
    echo "Not in WSL, skipping glzr symlink"
    exit 0
fi

if [ ! -L "$HOME/.glzr" ]; then
    WIN_USER=$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '[:space:]')
    if [ -z "$WIN_USER" ]; then
        echo "Could not determine Windows username, skipping"
        exit 0
    fi
    ln -sf "/mnt/c/Users/$WIN_USER/.glzr" "$HOME/.glzr"
fi
