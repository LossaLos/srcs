NAME = inception

all: up

build:
	docker-compose -f srcs/docker-compose.yml build

up:
	docker-compose -f srcs/docker-compose.yml up -d

down:
	docker-compose -f srcs/docker-compose.yml down

clean: down
	docker system prune -af
	docker volume prune -f

cleanfull: down
	docker system prune -af
	docker volume prune -f
	docker volume rm srcs_mariadb-data
	docker volume rm srcs_wordpress-data
	sudo rm -rf /home/fprevot/data/mariadb/*
	sudo rm -rf /home/fprevot/data/wordpress/*

re: clean all
