#!/bin/sh

mkfs.ext4 -L ROOT /dev/vda1
mount /dev/disk/by-label/ROOT /mnt
sv up ntpd
basestrap /mnt base base-devel runit elogind-runit
basestrap /mnt linux linux-firmware
fstabgen -U /mnt >> /mnt/etc/fstab

# Copy the chroot_script.sh to the /mnt directory so it's available inside the chroot environment
cp chroot_script.sh /mnt

# Use chroot to execute the chroot_script.sh from within the chroot environment
artix-chroot /mnt /bin/sh /chroot_script.sh

# Continue with the remaining commands after chroot exits
umount -R /mnt
reboot
