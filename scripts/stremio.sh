#!/usr/bin/env bash

if grep -q "Fedora" /etc/os-release; then

  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  flatpak install flathub com.stremio.Stremio

fi
