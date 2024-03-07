#!/usr/bin/env bash

timer=$1
new_time=$2

# Make override folder
mkdir -p "~/.config/systemd/user/${timer}.timer.d"

# Make override file
echo -e "[Timer]\nOnUnitActiveSec=${new_time}" \
    > ~/.config/systemd/user/${timer}.timer.d/override.conf

# Load changes
systemctl --user daemon-reload

