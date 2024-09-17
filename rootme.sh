#!/bin/bash

# Update and upgrade package list
apt update && apt upgrade -y

# Install required packages
PACKAGES="wget openssl-tool proot bash nano neofetch"
apt install $PACKAGES -y

# Configure Termux storage
termux-setup-storage

# Create a backup of bash.bashrc
cd /data/data/com.termux/files/usr/etc/
cp bash.bashrc bash.bashrc.bak

# Download and run Kali Linux installation script
cd /data/data/com.termux/files/usr/etc/Root
wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/Installer/Kali/kali.sh
bash kali.sh

# Configure system based on user choice
read -p "Please enter your choice (1 for Boot2Root or 2 for JustRoot): " choice

case $choice in
  1)
    # If user chooses Boot2Root, add a line to bash.bashrc to run start-kali.sh on boot
    echo "bash /data/data/com.termux/files/usr/etc/Root/start-kali.sh" >> /data/data/com.termux/files/usr/etc/bash.bashrc
    echo "Please restart Termux to become Root user"
    ;;
  2)
    # If user chooses JustRoot, add an alias to bash.bashrc to run start-kali.sh with the rootme command
    echo "alias rootme='bash /data/data/com.termux/files/usr/etc/Root/start-kali.sh'" >> /data/data/com.termux/files/usr/etc/bash.bashrc
    cd /data/data/com.termux/files/usr/etc
    source bash.bashrc
    echo "Please restart Termux and type 'rootme' to become Root user"
    ;;
  *)
    # If user enters an invalid choice, display an error message
    echo "Invalid choice. Please try again."
    exit
    ;;
esac
