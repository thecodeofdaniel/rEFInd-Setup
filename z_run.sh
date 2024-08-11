#!/bin/env bash

THEME_CONF_FILE="./conf/theme.conf"
REFIND_CONF_FILE="./conf/refind.conf"
PYTHON_FILE="./z_generate.py"

# Remove the conf directory
if [ -d "./conf" ]; then
    rm -rf conf
fi

# Create conf directory
mkdir conf

# Copy over icons from here to refind directory if not found
if [ ! -d "/boot/efi/EFI/refind/icons-custom" ]; then
    sudo cp -r ./icons /boot/efi/EFI/refind/icons-custom
fi

# Create the .conf files
python3 $PYTHON_FILE

# Move the theme.conf to refind dir
if [ -f $THEME_CONF_FILE ]; then
    cp $THEME_CONF_FILE $THEME_CONF_FILE.copy
    sudo chown root:root $THEME_CONF_FILE
    sudo mv $THEME_CONF_FILE /boot/efi/EFI/refind
    echo "Copied theme.conf to root!"
fi

# Move refind.conf to refind dir
if [ -f $REFIND_CONF_FILE ]; then
    cp $REFIND_CONF_FILE $REFIND_CONF_FILE.copy
    sudo chown root:root $REFIND_CONF_FILE
    sudo mv $REFIND_CONF_FILE /boot/efi/EFI/refind
    echo "Copied refind.conf to root!"
fi
