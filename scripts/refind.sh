#!/bin/env bash

# Grab the partuuid of root partition (/)
root_partuuid=$(sudo blkid -s PARTUUID -o value $(mount | grep ' / ' | cut -d' ' -f1))

# Grab the partuuid of esp partition (/boot/efi)
esp_partuuid=$(sudo blkid -s PARTUUID -o value $(mount | grep ' /boot/efi ' | cut -d' ' -f1))

# If Windows partuuid file is not found then ask user
if ! [ -f win_partuuid.txt ]; then
    printf "\n\e[1;33mSelect your windows partuuid\e[0m\n\n"
    lsblk -o NAME,SIZE,MOUNTPOINT,PARTUUID
    read -p $'\n\e[1;33mEnter the PARTUUID:\e[0m ' win_partuuid

    echo "${win_partuuid}" > win_partuuid.txt
# Otherwise grab Windows partuuid from file
else
    win_partuuid=$(cat win_partuuid.txt)
fi

# Source the custom config files by user
source ./config/refind_vars.cfg
big_icon_size=$(cat "theme.conf" | grep -oP 'big_icon_size \K\d+')
small_icon_size=$(cat "theme.conf" | grep -oP 'small_icon_size \K\d+')

# Where the conf file will be put
conf="/boot/efi/EFI/refind/refind.conf"

# REFIND.CONF
echo \
"$extra_args

menuentry \"${linux_name}\"
{
    icon    EFI/refind/theme/icons/${big_icon_size}-${small_icon_size}/${linux_icon}
    volume  ${esp_partuuid^^}
    loader  EFI/systemd/systemd-bootx64.efi
    options \"root=PARTUUID=${esp_partuuid} ro\"

    submenuentry \"using root (/)\"
    {
        volume  ${root_partuuid^^}
        loader  /boot/vmlinuz
        initrd  /boot/initrd.img
        options \"root=PARTUUID=${root_partuuid} ro\"
    }
    submenuentry \"using ESP (/boot/efi)\"
    {
        volume  ${esp_partuuid^^}
        loader  /boot/efi/EFI/Pop_OS-befced05-7acf-4424-98a1-639189cd8d61/vmlinuz.efi
        initrd  /boot/efi/EFI/Pop_OS-befced05-7acf-4424-98a1-639189cd8d61/initrd.img
        options \"root=PARTUUID=${esp_partuuid} ro\"
        disabled
    }
    submenuentry \"using (BOOTX64.EFI) from ESP\"
    {
        volume  ${esp_partuuid^^}
        loader  EFI/BOOT/BOOTX64.EFI
        options \"root=PARTUUID=${esp_partuuid} ro\"
        disabled
    }
}

menuentry \"${win_name}\"
{
    icon   EFI/refind/theme/icons/${big_icon_size}-${small_icon_size}/${win_icon}
    volume ${win_partuuid^^}
    loader EFI\Microsoft\Boot\bootmgfw.efi
}

include theme/theme.conf" > $conf
