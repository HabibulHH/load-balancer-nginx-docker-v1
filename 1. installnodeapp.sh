#!/bin/bash

# Update the package list
sudo apt update

# Install Node.js and npm
sudo apt install -y nodejs npm

# Install PM2 globally
sudo npm install -g pm2

# Create a directory for the Node.js app
mkdir ~/node-app
cd ~/node-app

# Create the provided Express.js app
cat << 'EOF' > app.js
const express = require('express');
const os = require('os');
const app = express();
const port = 4000;

// Middleware to log incoming requests
app.use((req, res, next) => {
  // Log incoming request details
  console.log(`[${new Date().toISOString()}] Received request on ${os.hostname()} from ${req.ip}`);
  next();
});

app.get('/', (req, res) => {
  res.send(`[${new Date().toISOString()}] Received request on ${os.hostname()} from ${req.ip}`);
});

app.listen(port, () => {
  console.log(`Node.js app listening at http://localhost:${port}`);
});
EOF

# Create a package.json file
cat << 'EOF' > package.json
{
  "name": "node-app",
  "version": "1.0.0",
  "description": "Simple Node.js app",
  "main": "app.js",
  "scripts": {
    "start": "node app.js"
  },
  "dependencies": {
    "express": "^4.17.1"
  }
}
EOF

# Install dependencies
npm install

# Start the Node.js app with PM2
pm2 start app.js --name "node-app"

# Configure PM2 to start on boot
pm2 startup systemd
sudo env PATH=$PATH:/usr/bin pm2 startup systemd -u $USER --hp /home/$USER
pm2 save

# Print the public IP address of the instance
curl http://checkip.amazonaws.com

echo "Node.js app is running and accessible at http://<your-ec2-instance-public-ip>:4000"
