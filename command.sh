
docker network create internal  
docker build -t my-node-app .  

docker run -d --name node-app --network internal -p 4000:4000 my-node-app
docker run -d --name node-app2 --network internal -p 4001:4000 my-node-app

docker run -d --name nginx --network internal -p 80:80 nginx:latest    

docker cp ./nginx.conf nginx:/etc/nginx/conf.d/default.conf 

docker restart nginx    
