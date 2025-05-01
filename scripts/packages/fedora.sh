#!/usr/bin/env bash

sudo dnf update -y

# Logitech
sudo dnf install solaar

# Godot
flatpak install flathub org.godotengine.Godot
