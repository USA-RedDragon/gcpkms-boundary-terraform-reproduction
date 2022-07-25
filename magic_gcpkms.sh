#!/bin/bash

# Exit if any of the intermediate steps fail
set -e

# Extract gcp key from the input into the KEY shell variables.
# jq will ensure that the values are properly quoted
# and escaped for consumption by the shell.
eval "$(jq -r '@sh "KEY=\(.key) FILENAME=\(.filename)"')"

echo -n "$KEY" | base64 -d > "$FILENAME"

# Safely produce a JSON object containing the result value.
# jq will ensure that the value is properly quoted
# and escaped to produce a valid JSON string.
jq -n --arg filename "$FILENAME" '{"filename":$filename}'
