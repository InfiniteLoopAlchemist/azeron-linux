#!/bin/bash
# .rpm postuninstall scriptlet — remove Azeron udev rules.
set -e

UDEV_DST="/etc/udev/rules.d/99-azeron.rules"

if [ -f "$UDEV_DST" ]; then
  rm -f "$UDEV_DST"
  if command -v udevadm >/dev/null 2>&1; then
    udevadm control --reload-rules || true
  fi
fi

exit 0
