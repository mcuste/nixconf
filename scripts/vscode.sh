#!/usr/bin/env bash

if grep -q "Fedora" /etc/os-release; then

  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" |\
    sudo tee /etc/yum.repos.d/vscode.repo >/dev/null

  dnf check-update
  sudo dnf install code # or code-insiders

fi

