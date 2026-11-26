#!/usr/bin/env bash
# CollingOS ISO build script (Stage 1+2). Run on Debian 12/13 (or a Debian container/VM) as root.
set -euo pipefail
cd "$(dirname "$0")"
# Windows zips/git lose the executable bit, so restore it
chmod +x auto/* config/hooks/live/*.chroot 2>/dev/null || true
if [ "$(id -u)" -ne 0 ]; then echo "Run as root: sudo ./build.sh"; exit 1; fi
apt-get update
apt-get install -y live-build debootstrap squashfs-tools xorriso grub-pc-bin grub-efi-amd64-bin mtools dosfstools
lb clean --purge || true
lb config
lb build 2>&1 | tee build.log
ls -lh ./*.iso
echo "Done. ISO: $(ls ./*.iso)"
