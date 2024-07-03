# load-balancer-nginx-docker-v1
![Architecture Diagram](./hld/system.png)
check the hld in HLD folder 

# Dockerized Node.js Project with Nginx Load Balancing

This project demonstrates how to Dockerize a Node.js application and set up Nginx as a load balancer to distribute traffic among multiple Node.js containers.

## Prerequisites

Make sure you have Docker installed on your machine. You can download and install Docker from [Docker's official website](https://www.docker.com/get-started).

## Project Structure

- **app.js**: Node.js application file.
- **Dockerfile**: Dockerfile for building the Node.js application image.
- **nginx.conf**: Custom Nginx configuration file for load balancing.

## Setup Instructions

### Step 1: Create Docker Network

Create a Docker network named `internal` to allow communication between containers:

```bash
docker network create internal
docker build -t my-node-app .

docker run -d --name node-app --network internal -p 4000:4000 my-node-app
docker run -d --name node-app2 --network internal -p 4001:4000 my-node-app
# Add more instances as needed, adjusting ports accordingly
docker run -d --name nginx --network internal -p 80:80 nginx:latest

docker cp ./nginx.conf nginx:/etc/nginx/conf.d/default.conf

docker restart nginx
