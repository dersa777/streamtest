#!/bin/bash

# Check if the script is run with superuser privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with superuser privileges (sudo)."
  exit 1
fi

# Install iperf3
sudo apt -y install iperf3

# Check if the installation was successful
if [ $? -eq 0 ]; then
  echo "iperf3 has been successfully installed."
else
  echo "Installation of iperf3 failed."
  exit 1
fi

# Install ZeroTier
curl -s https://install.zerotier.com | sudo bash

# Check if the installation was successful
if [ $? -eq 0 ]; then
  echo "ZeroTier has been successfully installed."
else
  echo "Installation of ZeroTier failed."
  exit 1
fi

# Start the ZeroTier service in daemon mode
sudo zerotier-one -d

# Join a specific ZeroTier network (replace with your network ID)
sudo zerotier-cli join ebe7fbd4451ebac6

# Start the iperf3 server
iperf3 -s
