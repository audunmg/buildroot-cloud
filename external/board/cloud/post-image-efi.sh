#!/bin/sh

set -e

cp "${BR2_EXTERNAL_CLOUDIMAGE_PATH}/board/cloud/genimage-efi.cfg" "${BINARIES_DIR}/genimage-efi.cfg"
support/scripts/genimage.sh -c "${BINARIES_DIR}/genimage-efi.cfg"
#qemu-img convert -p -f raw -O qcow2 output/images/disk.img disk.qcow2
