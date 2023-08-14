#!/bin/env python3

theme_vars = "./config/theme_vars.cfg"

try:
    with open(theme_vars, "r") as file:
        lines = file.readlines()
except FileNotFoundError:
    lines = []

values_to_write = [
    ("# icon sizes:", "1)128-48 or 2)256-96 or 3)384-144 or 4)512-192"),
    ("icon_size_sel", "1"),
    ("hideui_args", "hints"),
    ("showtools_args", "hidden_tags,firmware,shutdown")
]

with open(theme_vars, "a+") as file:
    for key, value in values_to_write:
        found = any(line.startswith(f"{key}=") for line in lines)

        if not found:
            file.write(f"{key}=\"{value}\"\n")

print(f"\n\x1b[33mThis is your \x1b[1m{theme_vars}\x1b[0m\x1b[33m file\x1b[0m")
with open(theme_vars, "r") as file:
    print(file.read(), end="")
