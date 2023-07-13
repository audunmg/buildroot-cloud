# Buildroot for cloud VMs (WIP)

I just want a VM where I can run docker compose and be happy.

This is an attempt at making small and immutable root images for cloud VMs with buildroot.


This is nothing new. The buildroot approach (and structure of this repo) is heavily inspired by [buildroot4kubernetes](https://github.com/afbjorklund/buildroot4kubernetes/) (so if you want this, but with kubernetes, go there, it's good stuff)

The package cloud-rc is only slightly modified from the original at [dtroyer/openwrt-packages](https://github.com/dtroyer/openwrt-packages)

Since I'm testing on Oracle cloud, that's what works at the moment. (openstack and aws might also work)

What works:

* booting
* getting and setting ssh-keys (both dropbear and openssh!, thanks dtroyer)
* getting and setting ip address

What doesn't work:
* extending the disk (manual for now)
* persisting storage. It's just a ramdisk overlay.
* some other things

What would be nice if it worked:
* Instead of tmpfs overlay, actually mount/overlay to persist only the bits that need writing to, like
	* Host config like:
	  * ssh host keys
	  * other things (like host firewall)
	  * wireguard config
	* docker stuff:
	  * images
	  * volumes
* zfs (actually builds and works, just a manual process)
* host firewall (maybe just load iptables rules file)
* selinux (no idea if it even works)
* collectd monitoring (because its small)
* other things
