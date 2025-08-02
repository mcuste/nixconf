#!/usr/bin/env bash

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip

mkdir -p ~/.local/share/fonts
unzip -d ~/.local/share/fonts JetBrainsMono.zip

fc-cache -fv

rm JetBrainsMono.zip
