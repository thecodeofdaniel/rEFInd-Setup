THEME_JSON = "../config/json/theme.json"
ENTRIES_JSON = "../config/json/entries.json"
REFIND_JSON = "../config/json/refind.json"

THEME_CONF = "../config/conf/theme.conf"
REFIND_CONF = "../config/conf/refind.conf"

# So bash scripts can evaluate and grab variables as well
if __name__ == "__main__":
    print(f"THEME_JSON={THEME_JSON}")
    print(f"ENTRIES_JSON={ENTRIES_JSON}")
    print(f"REFIND_JSON={REFIND_JSON}")
    print(f"THEME_CONF={THEME_CONF}")
    print(f"REFIND_CONF={REFIND_CONF}")
