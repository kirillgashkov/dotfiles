#!/bin/sh

if [ "$#" -eq 0 ]; then
    echo >&2 "$(basename "$0"): home files were not provided"
    exit 1
fi

for file in "$@"; do
    if [ "$(printf '%s' "$file" | cut -c1)" != "/" ]; then
        echo >&2 "$(basename "$0"): home file must be provided via an absolute path: $file"
        exit 1
    fi

    if [ ! -e "$file" ]; then
        echo >&2 "$(basename "$0"): provided home file does not exist: $file"
        exit 1
    fi
done

local_home="$HOME"

mkdir -p "$local_home"
if [ ! -d "$local_home" ]; then
    echo >&2 "$(basename "$0"): failed to provide local home directory for symlinks"
    exit 1
fi

for file in "$@"; do
    filename="$(basename "$file")"
    echo "$(tput setaf 3)Symlinking $filename$(tput sgr0)"
    ln -s "$file" "$local_home"

    if [ "$?" -ne 0 ]; then
        echo "$(tput setaf 1)Symlinking $filename has failed$(tput sgr0)"
    fi
done