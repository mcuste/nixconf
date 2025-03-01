#!/usr/bin/env bash

# See https://docs.docker.com/engine/install/fedora/

sudo dnf update -y

sudo dnf -y install dnf-plugins-core
sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable --now docker

sudo groupadd docker
sudo usermod -aG docker "$USER"
newgrp docker

echo "Running hello world contianer as a test..."
docker run hello-world

echo "Setup completed. Logout and login for docker group to take effect."
