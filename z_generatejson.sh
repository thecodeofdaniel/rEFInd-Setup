#!/bin/env bash

# List of JSON files and their corresponding example files
files=("./json/entries.json" "./json/refind.json" "./json/theme.json")
example_suffix=".example"

for file in "${files[@]}"; do
    example_file="$file$example_suffix"

    if [[ -f "$file" ]]; then
        # Check if the file is empty
        if [[ ! -s "$file" ]]; then
            echo "$file is empty. Creating from $example_file."
            cp "$example_file" "$file"
        fi
    else
        # If file does not exist, create it from example
        if [[ -f "$example_file" ]]; then
            echo "$file does not exist. Creating from $example_file."
            cp "$example_file" "$file"
        else
            echo "$example_file does not exist. Cannot create $file."
        fi
    fi
done
