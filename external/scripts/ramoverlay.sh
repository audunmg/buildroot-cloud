#!/bin/sh

rwroot=/overlay

echo -n  "RAM overlay"
[ -d "$rwroot" ] ||  mkdir $rwroot
mount -o mode=0755 -t tmpfs tmpfs $rwroot
mkdir $rwroot/upper
mkdir $rwroot/work
mount overlayfs:$rwroot /mnt -t overlay -o lowerdir=/,upperdir=$rwroot/upper,workdir=$rwroot/work
[ -d "/mnt/rom" ] ||  mkdir /mnt/rom
pivot_root /mnt /mnt/rom/
echo " mounted"
umount /rom/dev
mount -t devtmpfs devtmpfs /dev  -o rw,nosuid,relatime,size=188056k,nr_inodes=47014,mode=755,inode64
mount -t proc     proc     /proc -o rw,nosuid,nodev,noexec,relatime
