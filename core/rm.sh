#!/bin/bash

CORE_DIR="$(dirname "$(realpath "$0")")"
source "$CORE_DIR/global.sh"

initial_path=$(pwd)

if [[ "$EUID" -ne 0 ]]; then
  throw 1 "Please, run as administrator!"
fi

if [ -d "$SOURCE_DIR" ]; then
  rm -rf "$SOURCE_DIR"
fi

if [ -f "$EXECUTABLE_PATH" ]; then
  rm "$EXECUTABLE_PATH"
fi

if [ -f "$MAN_PATH" ]; then
  rm "$MAN_PATH"
fi

echo "wm uninstalled!"

cd "$initial_path" || exit
