#!/bin/bash

echo "Starting Ubuntu server setup..."

# Step 1: Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Step 2: Ensure SSH is installed and running
echo "Checking and installing SSH if necessary..."
if ! command -v ssh >/dev/null 2>&1; then
    echo "SSH is not installed. Installing OpenSSH Server..."
    sudo apt install -y openssh-server
    sudo systemctl enable ssh
    sudo systemctl start ssh
    echo "SSH installed and started successfully."
else
    echo "SSH is already installed."
fi

# Step 3: Configure firewall (UFW) to allow essential ports
echo "Configuring UFW firewall..."
sudo ufw allow OpenSSH
sudo ufw allow http
sudo ufw allow 443/tcp
sudo ufw enable

# Step 4: Install essential utilities
echo "Installing essential utilities..."
sudo apt install -y vim curl wget git net-tools htop

# Step 5: Set up Central Time zone and configure NTP
echo "Configuring timezone and installing NTP..."
sudo timedatectl set-timezone America/Chicago
sudo apt install -y ntp

# Step 6: Install Fail2Ban for basic security against brute-force attacks
echo "Installing Fail2Ban..."
sudo apt install -y fail2ban
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Step 7: Install Snap for package management
echo "Installing Snap..."
sudo apt install -y snapd

# Step 8: Configure automatic security updates
echo "Configuring unattended upgrades for automatic security updates..."
sudo apt install -y unattended-upgrades
sudo dpkg-reconfigure --priority=low unattended-upgrades

echo "Ubuntu server setup complete!"

