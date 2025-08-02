#!/usr/bin/env bash

echo -e "\nInstalling browsers...\n"

if grep -q "Fedora" /etc/os-release; then

  echo -e "\nInstalling Brave...\n"
  sudo dnf install dnf-plugins-core
  sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
  sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
  sudo dnf install brave-browser
  echo -e "\nBrave installed successfully.\n"

fi

echo -e "\nBrowsers installation completed.\n"
