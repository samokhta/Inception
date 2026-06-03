DCPATH = -f ./srcs/docker-compose.yml

RM = rm -rf

GREEN = \033[1;32m
CYAN = \033[1;36m
YELLOW = \033[1;33m
RESET = \033[0m

# Règles
all: up

up:
	@if [ -f ./srcs/.env ]; then \
		echo "$(YELLOW)Launching docker container...$(RESET)"; \
		mkdir -p /home/samokhta/data/; \
		mkdir -p /home/samokhta/data/mariadb/; \
		mkdir -p /home/samokhta/data/wordpress/; \
		docker compose $(DCPATH) up -d --build; \
		echo "$(CYAN)Launching completed!$(RESET)"; \
	else \
		echo "❌ Missing ./srcs/.env file"; \
		echo "👉 Please create it before running the project"; \
	fi

down:
	@echo "$(YELLOW)Stopping docker container...$(RESET)"
	@docker compose $(DCPATH) down
	@echo "$(CYAN)Docker container stopped !$(RESET)"

fclean: down
	sudo rm -rf /home/samokhta/data
	sudo docker volume rm -f srcs_wp_database
	sudo docker volume rm -f srcs_wp_files
	sudo docker system prune -af

re: fclean up

.PHONY: all up down re fclean