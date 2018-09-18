#!/bin/sh

set -e

cd "$(dirname "$0")"

mountpoint -q /boot/efi
mkdir -p /boot/efi/EFI/KeyTool
sbsign --key db/keytool.key --cert db/keytool.crt --output /boot/efi/EFI/KeyTool/KeyTool.efi /usr/share/efitools/efi/KeyTool.efi

if ! efibootmgr | grep --quiet -E '^Boot[0-9]{4}[* ] KeyTool$'; then
	efibootmgr --quiet --create-only --loader /EFI/KeyTool/KeyTool.efi --label KeyTool
fi
