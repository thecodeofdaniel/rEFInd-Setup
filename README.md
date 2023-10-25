# rEFInd-setup

A helping hand to setup your refind.conf and theme.conf for a dual boot system with Windows and Linux

## Turn your boot manager theme from this...

![custom refind theme](https://www.rodsbooks.com/refind/refind.png)

**to this...**

![default refind theme](https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/i/a0bb119c-973b-4db8-a589-a27c75e57b9c/d8gvwo8-c60dbd9c-6d8e-4758-9cf5-2756f1c2b5f1.png/v1/fill/w_854,h_480,q_80,strp/refind_theme_by_munlik_d8gvwo8-fullview.jpg)

## How to get Started!

- Make sure you've installed rEFInd

  ```
  sudo apt install refind
  ```
  - Accept the default option when installing

- Clone the repo to your ESP directory

  ```
  $ sudo git clone https://github.com/thecodeofdaniel/rEFInd-setup /boot/efi/EFI/refind/theme
  ```

- Create a backup of the default refind.conf

  ```
  $ sudo mv /boot/efi/EFI/refind/refind.conf /boot/efi/EFI/refind/refind.conf.bak
  ```

- Enter root user

  ```
  $ sudo su
  ```

- Head to the directory where you cloned the repo

  ```
  # cd /boot/efi/EFI/refind/theme
  ```

- Run the following script to get started

  ```
  # ./run.sh
  ```

- Edit your __refind.conf__ and __theme.conf__ in the __`config`__ directory

- There you will be able to change the size of the icons, the image of your linux distro, and some other arguments.

- Once you have edited your config to your liking, run the script again to create YOUR custom refind.conf and theme.conf!

  ```
  # ./run.sh
  ```
