#!/bin/bash

CORE_DIR="$(dirname "$(realpath "$0")")"
source "$CORE_DIR/global.sh"

initial_path=$(pwd)

if [ ! -f "$CORE_DIR/wm" ]; then
  echo "Error: The 'wm' script does not exist in the directory."
  exit 1
fi

echo "$OS"

if [[ "$EUID" -ne 0 ]]; then
  throw 1 "Please, run as administrator!"
fi

if [ -d "$SOURCE_DIR" ]; then
  rm -rf "$SOURCE_DIR"
fi

if [ -f "$EXECUTABLE_PATH" ]; then
  rm "$EXECUTABLE_PATH"
fi

mkdir -p "$SOURCE_DIR"
cp core/* "$SOURCE_DIR"

ln -sf "$SOURCE_DIR"/wm "$EXECUTABLE_PATH"

if echo "$OS" | grep -qi "Windows"; then
  bash_profile="$HOME/.bash_profile"
  source "$bash_profile"
else
  chmod +x "$EXECUTABLE_PATH"
  for file in "$SOURCE_DIR"/*.sh; do
    if [ -f "$file" ]; then
      chmod +x "$file"
      echo "Added execute permission to: $file"
    fi
  done
fi

echo "wm installed!"

cd "$initial_path" || exit
