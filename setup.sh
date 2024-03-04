#!/bin/bash

# Check if the script is being run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

echo "Running as root..."

# 1. Disable password authentication via SSH and ensure SSH key authentication is enabled
echo "Disabling password authentication and enabling SSH key authentication..."
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication no/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication no/PasswordAuthentication no/' /etc/ssh/sshd_config
systemctl reload sshd

# 2. Install fail2ban and configure it
echo "Installing fail2ban..."
apt update
apt install -y fail2ban

# Configure fail2ban
echo "Configuring fail2ban..."
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
cp /etc/fail2ban/jail.d/defaults-debian.conf /etc/fail2ban/jail.d/defaults-debian.local

# Add SSH jail configuration
tee -a /etc/fail2ban/jail.d/sshd.local << END
[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
END

# 3. Install UFW and allow SSH & update connections
echo "Installing UFW..."
apt install -y ufw

# Allow SSH & update connections
ufw allow ssh
ufw allow out 53/tcp
ufw allow out 53/udp
ufw allow out 80/tcp
ufw allow out 443/tcp
ufw allow out 123/tcp
ufw allow out 123/udp

# Configure UFW to work with fail2ban
echo "Configuring UFW to work with fail2ban..."
sed -i '/# net/ a \
# BEGIN F2B \
-A INPUT -j f2b-sshd \
-A FORWARD -j f2b-sshd \
# END F2B' /etc/ufw/before.rules

# Enable UFW
ufw --force enable

echo "Setup complete."
