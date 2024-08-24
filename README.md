# rEFInd Setup

A helping hand to setup your refind.conf and your theme.conf!

## Where are the icons from?

Originally created by [@munlik](https://github.com/munlik/refind-theme-regular),
with additional icons contributed by
[@bobafetthotmail](https://github.com/bobafetthotmail/refind-theme-regular).

## Transform your theme

**from this...**

![default refind theme](./imgs/default_refind.png)

**to this...**

![custom refind theme](./imgs/custom_refind.png)

## Create the JSON files

Create the json files using the following script. This will make a copy of the
`*.json.example` files. Edit them to fit your configuration.

```bash
./generate_json.sh
```

### What is needed?

The only requirement is that a name is needed for the entry. Everything else is
optional. However, you will need the volume, loader, initrd to make it usuable.
This is similar to the refind.conf already, but in JSON format. It's also easier
to configure with the provided theme. Just follow the example json files.

## Explanation

- `refind.json` will hold the settings for refind.

- `entries.json` will hold the menuentries and submenuentries.

  - A menuentry will need the `menuentry` key
    - If you want to add a submenuentry, you'll need to add the `children` key
  - A submenuentry will need the `submenuentry` key

- `theme.json` controls the preset theme for refind.

## Get Started

Create a backup of refind.conf and theme.conf if there is one.

```bash
sudo mv /boot/efi/EFI/refind/refind.conf /boot/efi/EFI/refind/refind.conf.bak
sudo mv /boot/efi/EFI/refind/theme.conf /boot/efi/EFI/refind/theme.conf.bak
```

## Run script

Once you're done editing the json files. Run the bash script to copy the custom
icons and your configurations to the refind directory. A copy of the conf files
will be in the `conf` directory.

```bash
./apply.sh
```
