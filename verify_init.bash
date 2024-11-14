#!/bin/bash

echo "Verifying Ubuntu server setup..."

# Check if essential utilities are installed
echo "Checking essential utilities..."
for pkg in vim curl wget git net-tools htop; do
  if dpkg -l | grep -q "$pkg"; then
    echo "✔ $pkg is installed."
  else
    echo "✘ $pkg is NOT installed."
  fi
done

# Check if UFW is active and configured
echo "Checking UFW status..."
if sudo ufw status | grep -q "Status: active"; then
  echo "✔ UFW is active."
else
  echo "✘ UFW is NOT active."
fi

# Verify allowed ports in UFW
for port in "OpenSSH" "80/tcp" "443/tcp"; do
  if sudo ufw status | grep -q "$port"; then
    echo "✔ UFW allows $port."
  else
    echo "✘ UFW does NOT allow $port."
  fi
done

# Check time zone setting
echo "Checking time zone..."
timezone=$(timedatectl | grep "Time zone" | awk '{print $3}')
if [ "$timezone" = "America/Chicago" ]; then
  echo "✔ Time zone is set to Central Time (America/Chicago)."
else
  echo "✘ Time zone is NOT set to Central Time (currently $timezone)."
fi

# Check NTP status
echo "Checking NTP status..."
if systemctl is-active --quiet ntp; then
  echo "✔ NTP is active."
else
  echo "✘ NTP is NOT active."
fi

# Check Fail2Ban installation and status
echo "Checking Fail2Ban status..."
if systemctl is-active --quiet fail2ban; then
  echo "✔ Fail2Ban is active."
else
  echo "✘ Fail2Ban is NOT active."
fi

# Check Snap installation
echo "Checking Snap installation..."
if snap version > /dev/null 2>&1; then
  echo "✔ Snap is installed."
else
  echo "✘ Snap is NOT installed."
fi

# Check for unattended upgrades status
echo "Checking unattended upgrades status..."
if systemctl is-active --quiet unattended-upgrades; then
  echo "✔ Unattended upgrades are active."
else
  echo "✘ Unattended upgrades are NOT active."
fi

echo "Verification complete!"

