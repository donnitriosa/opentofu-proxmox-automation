#!/bin/bash
# Recommended Base Setup for LXC

# 1. System Update
export DEBIAN_FRONTEND=noninteractive
apt-get update && apt-get upgrade -y

# 2. Essential Tools
apt-get install -y curl wget vim htop git net-tools locales

# 3. Timezone & Locales
timedatectl set-timezone Asia/Jakarta
sed -i 's/^# *\(en_US.UTF-8 UTF-8\)/\1/' /etc/locale.gen
locale-gen
update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# 4. Sudoers (Optional for root-based LXC, but good practice)
echo 'root ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/90-init-setup

echo "Recommended setup complete."
