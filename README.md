# CollingOS (Stage 1 + 2) — Debian 13 "trixie" + XFCE, by Colling Studio

Status: build system only. NO ISO has been built yet. Build it with the steps below.

## Why Debian Stable + XFCE for 4 GB RAM
- XFCE idles around 400-600 MB RAM; GNOME/KDE usually need more.
- Debian Stable is well tested and gets security updates (about 3 years of normal support, then LTS up to ~5 years).
- Real apt, real kernel, real firmware packages, real Calamares installer.
- zram (compressed swap in RAM) helps a lot on 4 GB.

## Build (on a Debian/Ubuntu PC, VM, or Debian container; ~10 GB free disk, takes 20-60 min)
    sudo ./build.sh
Result: `live-image-amd64.hybrid.iso` in this folder.
If you only have Windows: install a Debian VM (VirtualBox) and run it there.

## Test BEFORE using your laptop
    qemu-system-x86_64 -m 2048 -enable-kvm -cdrom live-image-amd64.hybrid.iso
(or boot it in VirtualBox). Check: desktop starts, Firefox opens, Calamares "Install" launcher works.

## Write to USB (this ERASES the USB drive!)
Use balenaEtcher or Rufus (DD mode) — safest. On Linux: `lsblk` to find your USB (e.g. /dev/sdX), then
    sudo dd if=live-image-amd64.hybrid.iso of=/dev/sdX bs=4M status=progress conv=fsync

## Checklist for Stage 1/2 (tick on real laptop)
[ ] Boots (UEFI or BIOS)  [ ] XFCE starts  [ ] Wi-Fi  [ ] Audio  [ ] Touchpad  [ ] Firefox  [ ] Installs to disk  [ ] `sudo apt update && sudo apt upgrade` works  [ ] Free RAM at idle (`free -m`)

## Notes
- Wi-Fi/Bluetooth chips needing non-free firmware are included from Debian's non-free-firmware (iwlwifi, realtek, atheros). Some chips (e.g. Broadcom) need extra packages — not every device is guaranteed.
- NVIDIA proprietary drivers are not included yet (Stage 7).
- Next: Stage 3 branding, then Calamares branding/language/wizard.
