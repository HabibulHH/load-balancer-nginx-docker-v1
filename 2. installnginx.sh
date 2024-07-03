#!/bin/bash

# Update the package list
sudo apt update

# Install Nginx
sudo apt install nginx -y

# Start the Nginx service
sudo systemctl start nginx

# Enable Nginx to start on boot
sudo systemctl enable nginx

# Allow Nginx through the firewall (if UFW is enabled)
sudo ufw allow 'Nginx Full'
sudo ufw reload

echo "Nginx installation and setup completed. Nginx is running and enabled to start on boot."
