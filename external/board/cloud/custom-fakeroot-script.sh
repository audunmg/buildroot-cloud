#!/bin/sh
#

# Create folders for persistence mountpoints:
for dir in root/compose var/lib/docker data data/ssh opt/containerd/lib opt/containerd/bin ; do 
    [ -d "${TARGET_DIR}/${dir}" ] ||  mkdir -p "${TARGET_DIR}/${dir}"
done

# Redirect some config files
for cfg in iptables.conf collectd.conf motd; do 
    if [ -f "${TARGET_DIR}/etc/${cfg}" ]; then
        rm "${TARGET_DIR}/etc/${cfg}"
        ln -s "../data/${cfg}" "${TARGET_DIR}/etc/${cfg}"
    fi
done
# Clean up
for remove in etc/sudoers.d etc/mosquitto; do
    rm -r "${TARGET_DIR:?}/${remove}"
done

# SSH config with temporary keys to /tmp, and persisted ones once data volume is unlocked.
cp "${BR2_EXTERNAL}/board/cloud/sshd_config" "${TARGET_DIR}/etc/ssh/sshd_config"
ln -s ../../tmp/ssh_host_rsa_key "${TARGET_DIR}/data/ssh/ssh_host_rsa_key"
ln -s ../../tmp/ssh_host_ecdsa_key "${TARGET_DIR}/data/ssh/ssh_host_ecdsa_key"
ln -s ../../tmp/ssh_host_ed25519_key "${TARGET_DIR}/data/ssh/ssh_host_ed25519_key"


# Motd with message to unlock data volume
cp "${BR2_EXTERNAL}/board/cloud/motd" "${TARGET_DIR}/data/motd"
sed -i "s/VERSION/Build ${BR2_VERSION}-linux-${BR2_LINUX_KERNEL_VERSION}-${BR2_NORMALIZED_ARCH}/" "${TARGET_DIR}/data/motd"

# Make docker not start until after volume is unlocked
rm "${TARGET_DIR}/etc/default/dockerd"
ln -sf "../../data/dockerd" "${TARGET_DIR}/etc/default/dockerd"
echo "exit 0" > "${TARGET_DIR}/data/dockerd"

