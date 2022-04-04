docker stop $(docker ps -a -q)
docker rm $(docker -s -a -q)
docker rmi $(docker images -q)
# docker-compose up --build --force-recreate
aws ecr get-login-password --region us-west-1 | docker login --username AWS --password-stdin 508154593707.dkr.ecr.us-west-1.amazonaws.com
docker compose build
docker tag golang-repo:latest 508154593707.dkr.ecr.us-west-1.amazonaws.com/golang-repo:latest
docker push 508154593707.dkr.ecr.us-west-1.amazonaws.com/golang-repo:latest