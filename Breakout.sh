#!/bin/sh
echo -ne '\033c\033]0;Breakout\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Breakout.x86_64" "$@"
