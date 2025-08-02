#!/usr/bin/env bash

if grep -q "Fedora" /etc/os-release; then

  # See https://rpmfusion.org/Howto/NVIDIA

  sudo dnf update -y # and reboot if you are not on the latest kernel
  sudo dnf install akmod-nvidia # rhel/centos users can use kmod-nvidia instead
  sudo dnf install xorg-x11-drv-nvidia-cuda #optional for cuda/nvdec/nvenc support

fi
