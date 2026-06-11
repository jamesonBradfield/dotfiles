#!/bin/bash
# chezmoi run_once_before script: ensures ~/.glzr symlinks to Windows side
if [ ! -L "$HOME/.glzr" ]; then
    ln -sf /mnt/c/Users/mcraf/.glzr "$HOME/.glzr"
fi
