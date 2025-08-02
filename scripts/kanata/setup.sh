#!/usr/bin/env bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

if grep -q "Fedora" /etc/os-release; then

    # Check if both groups exist
    if ! groups "$USER" | grep -q "input" || ! groups "$USER" | grep -q "uinput"; then
        echo "Please run 'setup_groups.sh' first"
        exit 1
    fi

    if [ -f "/etc/udev/rules.d/99-input.rules" ]; then
        echo "udev rules file already exists"
    else
        printf '%s\n' 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' |
            sudo tee /etc/udev/rules.d/99-input.rules >/dev/null
        echo "Created udev rules file, reloading udev rules..."

        sudo udevadm control --reload-rules && sudo udevadm trigger
        ls -l /dev/uinput

        sudo modprobe uinput
    fi

    if [ -f "$HOME/.config/systemd/user/kanata.service" ]; then
        systemctl --user stop kanata
        systemctl --user disable kanata
    fi

    mkdir -p "$HOME/.config/systemd/user"
    cp "$SCRIPT_DIR/kanata.service" "$HOME/.config/systemd/user/"

    mkdir -p "$HOME/.config/kanata"
    cp "$SCRIPT_DIR/config.kbd" "$HOME/.config/kanata/"

    systemctl --user daemon-reload
    systemctl --user enable kanata.service
    systemctl --user start kanata.service

    # check whether the service is running
    systemctl --user status kanata.service

fi
