#!/bin/env bash

THEME_CONF_FILE="./conf/theme.conf"
REFIND_CONF_FILE="./conf/refind.conf"

# Check if the script is running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

# Remove the conf directory
if [ -d "./conf" ]; then
    rm -rf conf
fi

# Create conf directory
mkdir conf

# Copy over icons from here to refind directory if not found
if [ ! -d "/boot/efi/EFI/refind/icons-custom" ]; then
    cp -r ./icons /boot/efi/EFI/refind/icons-custom
fi

# Create the .conf files
python3 zgenerate.py

# Move the theme.conf to refind dir
if [ -f $THEME_CONF_FILE ]; then
    cp $THEME_CONF_FILE $THEME_CONF_FILE.copy
    chown root:root $THEME_CONF_FILE
    mv $THEME_CONF_FILE /boot/efi/EFI/refind
    echo "Copied theme.conf to root!"
fi

# Move refind.conf to refind dir
if [ -f $REFIND_CONF_FILE ]; then
    cp $REFIND_CONF_FILE $REFIND_CONF_FILE.copy
    chown root:root $REFIND_CONF_FILE
    mv $REFIND_CONF_FILE /boot/efi/EFI/refind
    echo "Copied refind.conf to root!"
fi
