from refind import generate_refind_conf
from theme import generate_theme_conf


# Write the theme content to theme.conf
with open("conf/theme.conf", "w") as file:
    theme_conf = generate_theme_conf()
    if theme_conf:
        file.write(theme_conf)


# Write the refind_conf to refind.conf
with open("conf/refind.conf", "w") as file:
    refind_conf = generate_refind_conf()
    if refind_conf:
        file.write(refind_conf)
