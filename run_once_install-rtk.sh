#!/bin/bash
set -euo pipefail
# One-time: install rtk and mcp-rtk cargo packages
# These are hard dependencies for CodeCompanion tool calls and MCP servers

if ! command -v cargo &>/dev/null; then
    echo "cargo not found — install Rust first: curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
    exit 1
fi

echo "Installing rtk and mcp-rtk via cargo..."
cargo install rtk-lite-cc mcp-rtk
echo "Done: rtk and mcp-rtk installed."
