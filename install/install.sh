#!/usr/bin/env bash

# dependencies
echo " Processing dependencies..."
sudo ./install_dep.sh 
if [ $? -ne 0 ]; then
    echo FAILED TO INSTALL DEPENDENCIES
    return -1
fi

# services
echo " Processing services..."
sudo ./install_service.sh
if [ $? -ne 0 ]; then
    echo FAILED TO INSTALL SERVICES
    return -1
fi

# profile
echo " Processing profile..."
cp ../assests/.face ~/

# modmap
echo " Processing modmap..."
cp ../i3/.Xmodmap ~/

# wallpaper
echo " Processing wallpaper..."
wallpaler_dir='/usr/share/backgrounds/custom/'
wallpaper_dir+='AdventureTime_Cliff.png'

mkdir -p $wallpaler_dir
cp ../assests/wallpaper/AdventureTime_Cliff.png $wallpaler_dir

# emacs
echo "Processing emacs..."
mkdir -p ~/.emacs.d
mkdir -p ~/.emacs_backups
mkdir -p ~/.emacs_saves

cp ../emacs/*.el ~/.emacs.d/
cp -r ../emacs/theme ~/.emacs.d/

# i3
echo "Processing i3..."
mkdir -p ~/.config/i3/

sudo cp ../i3/i3status.conf /etc
cp ../i3/config ~/.config/i3/

# rofi
echo "Processing rofi..."
mkdir -p ~/.config/rofi/

sudo cp ../rofi/edited-sidebar.rasi /usr/share/rofi/themes/sidebar.rasi
cp ../rofi/config.rasi ~/.config/rofi/
