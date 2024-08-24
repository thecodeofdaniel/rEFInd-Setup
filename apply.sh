#!/bin/env bash

# Go into src directory
cd src

CONF_DIR="../config/conf"
ICONS_DIR_LOCAL="../icons"
ICONS_DIR="/boot/efi/EFI/refind/icons-custom"

# If conf dir doesn't exists, create it
if [ ! -d $CONF_DIR ]; then
    mkdir $CONF_DIR
fi

# Copy over icons from here to refind directory if not found
if [ ! -d $ICONS_DIR ]; then
    sudo cp -r $ICONS_DIR_LOCAL $ICONS_DIR
fi

# Grab the constants inside python file
eval "$(python3 constants.py)"

# Create the .conf files
python3 generate.py

# Move the theme.conf to refind dir
if [ -f $THEME_CONF ]; then
    cp $THEME_CONF $THEME_CONF.copy
    sudo chown root:root $THEME_CONF
    sudo mv $THEME_CONF /boot/efi/EFI/refind/
    echo "Copied theme.conf to root!"
fi

# Move refind.conf to refind dir
if [ -f $REFIND_CONF ]; then
    cp $REFIND_CONF $REFIND_CONF.copy
    sudo chown root:root $REFIND_CONF
    sudo mv $REFIND_CONF /boot/efi/EFI/refind/
    echo "Copied refind.conf to root!"
fi
