#!/usr/bin/env bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

mkdir -p "$HOME/.config/systemd/user"
cp "$SCRIPT_DIR/protonvpn.service" "$HOME/.config/systemd/user/"

systemctl --user daemon-reload
systemctl --user enable protonvpn.service
systemctl --user start protonvpn.service

# check whether the service is running
systemctl --user status protonvpn.service
