#!/usr/bin/env bash

echo -e "\nInstalling Steam...\n"

if grep -q "Fedora" /etc/os-release; then

  # See https://docs.fedoraproject.org/en-US/gaming/proton/

  sudo dnf update -y

  # Add nonfree repos
  sudo dnf install \
    "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm" \
    "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm" -y

  sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1

  sudo dnf install steam -y

fi

echo -e "\nSteam installation completed.\n"
