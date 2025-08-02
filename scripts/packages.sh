#!/usr/bin/env bash

if grep -q "Fedora" /etc/os-release; then

  sudo dnf update -y

  # Logitech
  sudo dnf install solaar

  # Godot
  # flatpak install flathub org.godotengine.Godot -- install binary instead

fi
