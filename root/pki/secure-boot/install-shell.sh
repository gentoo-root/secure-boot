#!/bin/sh

set -e

cd "$(dirname "$0")"

mountpoint -q /boot/efi
sbsign --key db/shell.key --cert db/shell.crt --output /boot/efi/shellx64.efi /usr/share/uefi-shell/shellx64_v2.efi
