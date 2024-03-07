#!/usr/bin/env bash

# Make override folder
mkdir -p ~/.config/systemd/user/nextcloud-sync.timer.d

# Make override file
echo -e "[Timer]\nOnUnitActiveSec=$1" \
    > ~/.config/systemd/user/nextcloud-sync.timer.d/override.conf

# Load changes
systemctl --user daemon-reload

