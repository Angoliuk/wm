#!/bin/bash

CORE_DIR="$(dirname "$(realpath "$0")")"
source "$CORE_DIR/global.sh"

call_dir=$(pwd)
root=""
name=script

while [[ "$#" -gt 0 ]]; do
  case $1 in
    -n|--name) name="$2"; shift ;;
    --root) root="$2"; shift ;;
    *) echo "Unknown parameter passed: $1" ;;
  esac
  shift
done

cd "$root" || exit

file="$(get_scripts_folder "$root")/$name.sh"

[ -f "$file" ] && throw 1 "File $file already exists"

cp "$(dirname "$0")/health.sh" "$file"

[ ! -f "$file" ] && throw 1 "File $file not created"


if echo "$OS" | grep -qi "Windows"; then
  if [ -f "$file" ]; then
    sudo chmod +x "$file"
    echo "Added execute permission to: $file"
  fi
fi

cd "$call_dir" || exit
