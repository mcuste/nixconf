#!/usr/bin/env bash

if grep -q "Fedora" /etc/os-release; then

    # Add user to the input group if not already member
    if ! groups "$USER" | grep -q "input"; then
        echo "Adding user to input group..."
        sudo usermod -aG input "$USER"
        echo "User added to the 'input' group. Please logout and login."
    fi

    # Create uinput group if it doesn't exist
    if ! getent group uinput >/dev/null; then
        echo "Creating uinput group..."
        sudo groupadd uinput
    fi

    # Add user to the uinput group if not already member
    if ! groups "$USER" | grep -q "uinput"; then
        echo "Adding user to uinput group..."
        sudo usermod -aG uinput "$USER"
        echo "User added to the 'uinput' group. Please logout and login."
    fi

fi
