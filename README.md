# rEFInd Setup

A helping hand to setup your refind.conf and your theme.conf!

## Where are the icons from?

Originally created by @munlik, with additional icons contributed by
@bobafetthotmail.

## Transform your theme

**from this...**

![default refind theme](./imgs/default_refind.png)

**to this...**

![custom refind theme](./imgs/custom_refind.png)

## Create the JSON files

Create the json files using the following script. This will make a copy of the
`*.json.example` files. Edit them to fit your configuration.

```bash
./zgeneratejson.sh
```

### What is needed?

The only requirement is that a name is needed for the entry. Everything else is
optional. However you will obviously need the volume, loader, initrd to make
it usuable. This is similar to the refind.conf already, but in JSON format. It's
also easier to configure with the provided theme. Just follow the example json
files.

## Explanation

- `refind.json` will hold the settings for refind.

- `entries.json` will hold the menuentries and submenuentries.

  - The required keys will be the name for these entries
    (`menuentry`/`submenuentry`)

- `theme.json` controls the look of refind.

## Backup

Create a backup of previous refind.conf file and theme.conf.

```bash
mv refind.conf refind.conf.bak
mv theme.conf theme.conf.bak
```

## Run

Once you're done editing the json files. Run the bash script to copy the custom
icons and your configurations to the refind directory. Run the sudo since those
files will belong to root now. However, a copy of the conf files will be in the
`conf` directory.

```bash
sudo ./zrun.sh
```
