#!/usr/bin/env bash

set -euo pipefail

# Install nix using Determinate Systems' installer
# https://github.com/DeterminateSystems/nix-installer
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install

. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

# Install home-manager temporarily
nix shell nixpkgs#home-manager

# Backup exiting bash files
mkdir ~/.bash_backup
mv ~/.bashrc ~/.bash_profile ~/.bash_backup/

# Install home-manager config
home-manager switch --flake github:mcuste/nixconf#{{PROFILE}}

# Setup ssh key
mkdir ~/.ssh && pushd ~/.ssh && ssh-keygen -t ed25519 && popd
echo "Add the following public key to your GitHub account:"
cat ~/.ssh/id_ed25519.pub
read -p "Press any key after setting up SSH key on GitHub to continue"

# Clone nixconf
git clone git@github.com:mcuste/nixconf.git ~/nixconf
echo "All set! The nixconf repository has been cloned to ~/nixconf."
echo "You can now use 'nh' CLI tool to manage your home-manager state."
