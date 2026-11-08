#!/usr/bin/env bash


echo "Installing Script..."
# User scripts
mkdir -p ~/.local/script/
cp ../scripts/lock.sh /.local/script/

# volume-settings
sudo cp ../scripts/adjust-volume.sh /usr/local/bin/

# monitor battery, optional for desktops, not used anymore.
