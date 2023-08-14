#!/bin/env bash

source ./config/theme_vars.cfg

function _icon_size
{
    selection=$1

    case $selection in

        1)
        big="128"
        small="48";;

        2)
        big="256"
        small="96";;

        3)
        big="384"
        small="144";;

        4)
        big="512"
        small="192";;

        *)
        printf "$selection is not a selection, please pick between 1-4\n"
        exit 1;;
    esac
}

_icon_size $icon_size_sel


# THEME.CONF
echo \
"# HIDE_UI
hideui $hideui_args
# e.g.: hints,label

# ICON
icons_dir theme/icons/${big}-${small}

# ICON_SIZE
big_icon_size $big
small_icon_size $small
# e.g.: 128-48, 256-96, 384-144, 512-192

# BACKGROUND_IMAGE
banner theme/icons/other/banner.png

# SELECTION_IMAGE
selection_big theme/icons/other/line.png
selection_small theme/icons/other/triangle.png

# TOOLS
showtools $showtools_args
#e.g.: hidden_tags, firmware, shutdown, bootorder

For more infomation: https://www.rodsbooks.com/refind/configfile.html" > theme.conf
