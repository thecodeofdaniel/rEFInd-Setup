#!/bin/env bash

# List of JSON files and their corresponding example files
BASE_PATH="./config/json"
JSON_FILES=("entries.json" "refind.json" "theme.json")

for file in "${JSON_FILES[@]}"; do
    file="$BASE_PATH/$file"
    example_file="$file.example"

    if [[ -f "$file" ]]; then
        # Check if the file is empty
        if [[ ! -s "$file" ]]; then
            echo "$file is empty. Creating from $example_file."
            cp "$example_file" "$file"
        # Otherwise file already exists
        else
            echo "$file already exists"
        fi
    else
        # If file does not exist, create it from example
        if [[ -f "$example_file" ]]; then
            echo "$file does not exist. Creating from $example_file."
            cp "$example_file" "$file"
        # Otherwise example file does not exist
        else
            echo "$example_file does not exist. Cannot create $file."
        fi
    fi
done
