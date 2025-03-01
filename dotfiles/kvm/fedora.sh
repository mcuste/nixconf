#!/usr/bin/env bash

sudo dnf update -y

sudo dnf group install --with-optional virtualization

sudo systemctl enable libvirtd
sudo systemctl start libvirtd

lsmod | grep kvm
