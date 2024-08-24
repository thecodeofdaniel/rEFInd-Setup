import json

from constants import THEME_JSON


def get_icon_sizes() -> list[str] | list[None]:
    with open(THEME_JSON) as file:
        theme_data = json.load(file)

    if not theme_data.get("icon_size", False):
        return None, None

    return theme_data["icon_size"].split("-")


def generate_theme_conf() -> str | None:
    [big_icon_size, small_icon_size] = get_icon_sizes()

    if not big_icon_size and not small_icon_size:
        return None

    with open(THEME_JSON) as file:
        theme_data = json.load(file)

    if theme_data.get("hideui", False):
        hideui_args = ", ".join(theme_data["hideui"])

    if theme_data.get("showtools", False):
        showtools_args = ", ".join(theme_data["showtools"])

    theme_conf = f"""# HIDE_UI
hideui {hideui_args}
# e.g: hints,label

# ICON
icons_dir icons-custom/{big_icon_size}-{small_icon_size}

# ICON_SIZE
big_icon_size {big_icon_size}
small_icon_size {small_icon_size}
# e.g: 128-48, 256-96, 384-144, 512-192

# BACKGROUND_IMAGE
banner icons-custom/other/bg.png

# SELECTION_IMAGE
selection_big icons-custom/other/selection-big.png
selection_small icons-custom/other/selection-small.png

# TOOLS
showtools {showtools_args}
#e.g: hidden_tags, firmware, shutdown, bootorder

# For more information: https://www.rodsbooks.com/refind/configfile.html
"""
    return theme_conf
