#!/bin/env python3

refind_vars = "./config/refind_vars.cfg"

try:
    with open(refind_vars, "r") as file:
        lines = file.readlines()
except FileNotFoundError:
    lines = []

values_to_write = [
    ("linux_name", "Pop!_OS"),
    ("linux_icon", "os_pop.png"),
    ("win_name", "Windows 10"),
    ("win_icon", "os_windows.png"),
    ("extra_args","""
timeout 60
shutdown_after_timeout true
use_nvram false
resolution max
"""),
]

with open(refind_vars, "a+") as file:
    for key, value in values_to_write:
        found = any(line.startswith(f"{key}=") for line in lines)

        if not found:
            file.write(f"{key}=\"{value}\"\n")

print(f"\n\x1b[33mThis is your \x1b[1m{refind_vars}\x1b[0m\x1b[33m file\x1b[0m")
with open(refind_vars, "r") as file:
    print(file.read(), end="")
