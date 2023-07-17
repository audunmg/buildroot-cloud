# Buildroot for cloud VMs (WIP)

I just want a VM where I can run docker compose and be happy.

This is an attempt at making small root images (<200MB) for cloud VMs with buildroot.

This is nothing new. The buildroot approach (and structure of this repo) is heavily inspired by [buildroot4kubernetes](https://github.com/afbjorklund/buildroot4kubernetes/) (so if you want this, but with kubernetes, go there, it's good stuff)

The package cloud-rc is only slightly modified from the original at [dtroyer/openwrt-packages](https://github.com/dtroyer/openwrt-packages), but probably needs work to be more flexible and easier to maintain in a buildroot context.

Since I'm testing on Oracle cloud, that's what works at the moment. (openstack and aws might also work)

What works:

- [X] booting
- [X] getting and setting ssh-keys (both dropbear and openssh!, thanks dtroyer)
- [X] getting and setting ip address correctly
- [X] setting up persistent encrypted storage

Todo:
- [X] Extending the disk
- [x] Persistent zfs on luks storage.
- [ ] Refactor rc-cloud for this project
   - It is very tied into OpenWRT, which makes it hard to extend
   - Needs some work to function with providers:
   - [ ] NoCloud (high priority for rapid local testing)
   - [ ] DigitalOcean
   - [ ] Hetzner? Might just need testing
   - [ ] Oracle
   - Currently configures:
   - [x] Hostname
   - [x] ssh-keys
   - [ ] any other things
- [ ] some other things

What would be nice if it worked:
* Instead of tmpfs overlay, actually mount/overlay to persist only the bits that need writing to, like
	- [ ] Host config like:
	  - [x] ssh host keys
	  - [x] other things (like host firewall)
	  - [ ] wireguard config
	- [x] docker stuff:
	  - [x] images
	  - [x] volumes
- [x] zfs (actually builds and works, just a manual process)
- [ ] host firewall (maybe just load iptables rules file)
- [ ] selinux (no idea if it even works)
- [x] collectd monitoring (because its small)
- [ ] other things
