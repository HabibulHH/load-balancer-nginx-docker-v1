#!/bin/bash

# Create nginx.sh file with the provided contents
cat << 'EOF' > nginx.sh
#!/bin/bash


# Install Nginx
sudo apt install nginx -y

# Backup existing Nginx configuration file
sudo cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup

# Replace Nginx configuration with the provided setup
cat << 'EOL' | sudo tee /etc/nginx/nginx.conf
user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
    worker_connections 768;
}

http {
    upstream backend {
        server 122.248.209.160:4000 weight=3;
        server 52.77.216.135:4000 weight=1;
    }

    server {
        listen 80;

        location / {
            proxy_pass http://backend;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }
    }
    
    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;
    
    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*;
}
EOL

# Test the Nginx configuration for syntax errors
sudo nginx -t

# Restart Nginx to apply the changes
sudo systemctl restart nginx

echo "Nginx installation and configuration completed."
EOF

# Make the nginx.sh script executable
chmod +x nginx.sh

# Execute the nginx.sh script
./nginx.sh
