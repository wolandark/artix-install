#!/bin/sh

ln -sf /usr/share/zoneinfo/Asia/Tehran /etc/localtime
hwclock --systohc
sed -i 's/^#en_US\.UTF-8/en_US.UTF-8/' /etc/locale.gen
locale-gen
pacman -S grub os-prober efibootmgr
grub-install --recheck /dev/vda
grub-mkconfig -o /boot/grub/grub.cfg
echo "Enter Root Password"
passwd
echo "Enter User Name"
read us
useradd -m "$us"
echo "Enter "$us" Password"
passwd "$us"
usermod -aG wheel "$us"
echo "artix" > /etc/hostname
echo "127.0.0.1        localhost
::1              localhost
127.0.1.1        myhostname.localdomain  myhostname
" > /etc/hosts
pacman -S dhcpcd dhcpcd-runit
ln -s /etc/runit/sv/dhcp /etc/runit/runsvdir/default
pacman -S connman-runit connman-gtk
ln -s /etc/runit/sv/connmand /etc/runit/runsvdir/default
sed -i '/^# %wheel/s/^# //' /etc/sudoers
pacman -S vim 
