#!/bin/sh
#
echo Add ramoverlay to early startup
sed '/::sysinit:.sbin.ramoverlay.sh/d ; /Startup the system/a ::sysinit:/sbin/ramoverlay.sh' -i ${TARGET_DIR}/etc/inittab
cp "${BR2_EXTERNAL}/scripts/"ramoverlay.sh  ${TARGET_DIR}/sbin/ramoverlay.sh
[ -d "${TARGET_DIR}/overlay" ] ||  mkdir ${TARGET_DIR}/overlay

