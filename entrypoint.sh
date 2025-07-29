#!/bin/bash

set -eo pipefail

eval "$(dbus-launch --sh-syntax)"
mkdir -p ~/.cache
mkdir -p ~/.local/share/keyrings # where the automatic keyring is created
eval "$(printf '\n' | gnome-keyring-daemon --unlock)"
eval "$(printf '\n' | gnome-keyring-daemon --start)"

exec /usr/local/bin/openconnect-wrapper.expect "$@"
