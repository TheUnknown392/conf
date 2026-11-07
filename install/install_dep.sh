#!/usr/bin/env bash

echo "Installing Dependencies..."
apt_deps='emacs picom x11-xserver-utils xfce4-clipman alttab rofi feh xcape alacritty';

sudo apt update;
sudo apt install $apt_deps;



