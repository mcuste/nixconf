#!/usr/bin/env bash

if grep -q "Fedora" /etc/os-release; then

  # echo -e "\nInstalling Ghostty...\n"
  # sudo dnf copr enable pgdev/ghostty
  # sudo dnf install ghostty
  # echo -e "\nGhostty installation completed.\n"

  echo -e "\nInstalling Alacritty...\n"
  sudo dnf install alacritty -y
  echo -e "\nAlacritty installation completed.\n"

fi
