#!/bin/env bash

# Description:   This script will create your THEME.CONF and REFIND.CONF
#
# Note:          This script only assumes that you're dual-booting
#                with Linux and Windows. You can edit some of these settings
#                in the "config" directory


# This makes sure that script is run in correct path
if [[ $(dirname "$0") != '.' ]]; then
    echo "Please execute this script where it's located :)"
    exit 1
fi

# Create custom variables if not already done so
mkdir config 2>/dev/null
python3 ./scripts/theme_vars.py
python3 ./scripts/refind_vars.py

# Create THEME.CONF and REFIND.CONF
bash ./scripts/theme.sh
bash ./scripts/refind.sh
