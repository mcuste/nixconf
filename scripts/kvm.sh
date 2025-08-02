#!/usr/bin/env bash

if grep -q "Fedora" /etc/os-release; then

  sudo dnf update -y

  sudo dnf group install --with-optional virtualization

  sudo systemctl enable libvirtd
  sudo systemctl start libvirtd

  lsmod | grep kvm

fi
