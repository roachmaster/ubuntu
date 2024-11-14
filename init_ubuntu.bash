#!/bin/bash

echo "Starting Ubuntu server setup..."

# Step 1: Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Step 2: Configure firewall (UFW) to allow essential ports
echo "Configuring UFW firewall..."
sudo ufw allow OpenSSH
sudo ufw allow http
sudo ufw allow https
sudo ufw enable

# Step 3: Install essential utilities
echo "Installing essential utilities..."
sudo apt install -y vim curl wget git net-tools htop

# Step 4: Set up Central Time zone and configure NTP
echo "Configuring timezone and installing NTP..."
sudo timedatectl set-timezone America/Chicago
sudo apt install -y ntp

# Step 5: Install Fail2Ban for basic security against brute-force attacks
echo "Installing Fail2Ban..."
sudo apt install -y fail2ban
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Step 6: Install Snap for package management
echo "Installing Snap..."
sudo apt install -y snapd

# Step 7: Configure automatic security updates
echo "Configuring unattended upgrades for automatic security updates..."
sudo apt install -y unattended-upgrades
sudo dpkg-reconfigure --priority=low unattended-upgrades

echo "Ubuntu server setup complete!"

