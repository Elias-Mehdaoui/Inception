NAME		= inception

SRCS		= ./srcs/docker-compose.yml
DATA_PATH	= /home/elias/data

DOCKER_COMPOSE	= docker compose -f $(SRCS)

all: build

build:
	@echo "Preparing data directories..."
	@mkdir -p $(DATA_PATH)/mariadb
	@mkdir -p $(DATA_PATH)/wordpress
	@echo "Building images and starting containers..."
	@$(DOCKER_COMPOSE) up -d --build

down:
	@echo "Stopping containers..."
	@$(DOCKER_COMPOSE) down

clean: down
	@echo "Cleaning Docker images..."
	@docker system prune -a -f

fclean: clean
	@echo "Removing volumes and local data..."
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@sudo rm -rf $(DATA_PATH)
	@echo "Full cleanup completed."

re: fclean all

status:
	@$(DOCKER_COMPOSE) ps

.PHONY: all build down clean fclean re status

