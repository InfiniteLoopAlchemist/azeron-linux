#!/bin/bash
# .rpm postinstall scriptlet — install Azeron udev rules and reload udev.
# Mirrors scripts/deb/after-install.sh; see that file for context.
set -e

APP_DIR="/opt/azeron-software"
UDEV_SRC="$APP_DIR/udev/99-azeron.rules"
UDEV_DST="/etc/udev/rules.d/99-azeron.rules"

if [ -f "$UDEV_SRC" ]; then
  install -m 644 "$UDEV_SRC" "$UDEV_DST"
  if command -v udevadm >/dev/null 2>&1; then
    udevadm control --reload-rules || true
    udevadm trigger --subsystem-match=hidraw --subsystem-match=usb --action=change || true
  fi
  echo "Azeron udev rules installed at $UDEV_DST."
  echo "If your Azeron is currently connected, unplug and replug it for the rules to apply."
else
  echo "Warning: $UDEV_SRC not found; install udev rules manually from /opt/azeron-software/udev/." >&2
fi

exit 0
