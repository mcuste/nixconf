#!/usr/bin/env bash

if grep -q "Fedora" /etc/os-release; then

  sudo dnf update -y
  sudo dnf install nodejs -y
  npm --version

fi
