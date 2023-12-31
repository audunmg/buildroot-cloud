BUILDROOT_BRANCH = 2023.02.x




BUILDROOT_OPTIONS += BR2_EXTERNAL=$(PWD)/external

BUILDROOT_TARGET = cloud_x86_64_defconfig


buildroot:
	git clone --single-branch --branch=$(BUILDROOT_BRANCH) \
		--no-tags --depth=1 https://github.com/buildroot/buildroot.git

buildroot/.config: external/configs/$(BUILDROOT_TARGET)
	$(MAKE) -C buildroot $(BUILDROOT_OPTIONS) $(BUILDROOT_TARGET) 

.PHONY: clean
clean:
	rm -f buildroot/.config
	$(MAKE) -C buildroot $(BUILDROOT_OPTIONS) clean

# buildroot/dl
download: buildroot/.config
	$(MAKE) -C buildroot $(BUILDROOT_OPTIONS) source


# buildroot/output
output/disk.img: buildroot/.config
	$(MAKE) -C buildroot $(BUILDROOT_OPTIONS) all
	@mkdir -p output
	cp --sparse=always buildroot/output/images/disk.img output/disk.img

disk.qcow2: output/disk.img
	qemu-img convert -f raw -O qcow2 output/disk.img $@
	qemu-img resize $@ 20G

run:
	qemu-system-x86_64 -cpu host -m 400M -enable-kvm -bios /usr/share/edk2/x64/OVMF_CODE.fd -M pc-i440fx-4.2   -net nic,model=virtio -net user  -device virtio-scsi-pci -drive id=hd1,file=disk.qcow2,format=qcow2,if=none -device scsi-hd,drive=hd1  -vga none
