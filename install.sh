#!/bin/sh

echo 'label: dos' | sudo sfdisk --no-reread /dev/vda
echo ',,83' | sudo sfdisk --no-reread --append /dev/vda
mkfs.ext4 -L ROOT /dev/vda1
mount /dev/disk/by-label/ROOT /mnt
sv up ntpd
basestrap /mnt base base-devel runit elogind-runit
basestrap /mnt linux linux-firmware
fstabgen -U /mnt >> /mnt/etc/fstab

# copy the chroot_script.sh to the /mnt 
cp chroot_script.sh /mnt

# execute the chroot_script.sh from within the chroot environment
artix-chroot /mnt /bin/sh /chroot_script.sh

# rest of script after chroot
umount -R /mnt
reboot
