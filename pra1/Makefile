build:
	docker build -t ft_server .

run:
	docker run -it --rm -p 80:80 -p 443:443 ft_server

kill:
	-docker kill `docker ps -qa`

iclean: kill
	=docker rmi `docker images -q`

cclean: kill
	-docker rm `docker ps -qa`

prune:
	docker system prune
