import json
from theme import get_icon_sizes


# Icon sizes for images
[BIG_ICON_SIZE, SMALL_ICON_SIZE] = get_icon_sizes()
if not BIG_ICON_SIZE and not SMALL_ICON_SIZE:
    print("No icon_size key specified!")
    exit(1)

# Keys that should be ignored since they've been checked
CHECKED_KEYS = ("children", "disabled", "volume", "options", "icon")


# Grabs all the keys in a dict or json
def get_keys(data, keys_set=None) -> set[str]:
    if keys_set is None:
        keys_set = set()

    if isinstance(data, dict):
        for key in data.keys():
            keys_set.add(key)
            get_keys(data[key], keys_set)  # Recursively process nested dictionaries
    elif isinstance(data, list):
        for item in data:
            get_keys(item, keys_set)  # Recursively process list items

    return keys_set


# Returns whether string should be indented
def is_menuentry(indent: str, entry: str) -> str:
    return indent if entry == "submenuentry" else ""


# Retuns true or false if key is present in data
def isKey(key: str, data) -> bool:
    return True if data.get(key, False) else False


# Create the refind settings content
def get_refind_settings(data, keys: set[str]) -> str:
    string = ""

    for key in keys:
        value = str(data[key])
        string += f"{key} {value.lower()}\n"
    string += "\n"

    return string


# Parse through entries to create content
def get_refind_entries(nodes, entry: str, keys: set[str], path: str) -> str:
    tab = "\t"
    string = ""

    for node in nodes:
        # Add name of entry
        if not isKey(entry, node):
            print(f"Need to have {entry} key\n")
            break
        else:
            string += is_menuentry(tab, entry)
            string += f'{entry} "{node[entry]}"' + " {\n"

        # Add icon path
        if isKey("icon", node):
            img_name = node["icon"]
            node["icon"] = (
                f"{path}/icons-custom/{BIG_ICON_SIZE}-{SMALL_ICON_SIZE}/{img_name}"
            )
            string += is_menuentry(tab, entry)
            string += f'{tab}icon {node["icon"]}\n'

        # Add volume
        if isKey("volume", node):
            node["volume"] = node["volume"].upper()
            string += is_menuentry(tab, entry)
            string += f'{tab}volume {node["volume"]}\n'

        # Add rest of keys
        for key in keys:
            if key == entry or key in CHECKED_KEYS:
                continue
            if isKey(key, node):
                string += is_menuentry(tab, entry)
                string += f"{tab}{key} {node[key]}\n"

        # Add options
        if isKey("options", node):
            node["options"] = (
                f'root=PARTUUID={(node["volume"].lower())} {", ".join(node["options"])}'
            )
            string += is_menuentry(tab, entry)
            string += f'{tab}options "{node["options"]}"\n'

        # Add disabled option
        if isKey("disabled", node):
            if node["disabled"] == True:
                string += is_menuentry(tab, entry)
                string += f"{tab}disabled\n"

        # Continue if menuentry has children (submenuentries)
        if entry == "menuentry" and isKey("children", node):
            string += get_refind_entries(node["children"], "submenuentry", keys, path)

        # Add curly bracket to close entry
        string += is_menuentry(tab, entry)
        string += "}\n"

    return string


# Generate refind conf
def generate_refind_conf() -> str | None:
    # Start the refind content to refind.conf
    refind_conf = ""

    # Get settings for refind.json
    with open("json/refind.json") as file:
        settings_data = json.load(file)
        refind_conf += get_refind_settings(settings_data, get_keys(settings_data))

    # Get the entries from json file
    with open("json/entries.json") as file:
        entries_data = json.load(file)

        # Get all unique keys inside entries.json
        keys = get_keys(entries_data)

        if "REFIND_PATH" not in keys:
            print("REFIND_PATH key is not found in json/entries.json")
            return None
        else:
            path = entries_data["REFIND_PATH"]

        # Get all the entries
        entries = get_refind_entries(entries_data["root"], "menuentry", keys, path)
        refind_conf += entries
        refind_conf += "\ninclude theme.conf\n"

    return refind_conf
