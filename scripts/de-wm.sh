#!/usr/bin/env bash

echo -e "\nInstalling DE/WM...\n"

if grep -q "Fedora" /etc/os-release; then

  echo -e "\nInstalling Cosmic DE...\n"
  sudo dnf copr enable ryanabx/cosmic-epoch
  sudo dnf install cosmic-desktop
  echo -e "\nCosmic DE installed successfully.\n"

fi

echo -e "\nDE/WM installation completed.\n"
