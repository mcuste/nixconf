#!/usr/bin/env bash

echo -e "\nInstalling fonts...\n"

if grep -q "Fedora" /etc/os-release; then

  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
  mkdir -p ~/.local/share/fonts
  unzip -d ~/.local/share/fonts JetBrainsMono.zip
  fc-cache -fv
  rm JetBrainsMono.zip

fi

echo -e "\nFont installation completed.\n"
