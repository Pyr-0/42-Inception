#===========COLORS=========#


BLACK		:= $(shell tput -Txterm setaf 0)
RED			:= $(shell tput -Txterm setaf 1)
GREEN		:= $(shell tput -Txterm setaf 2)
YELLOW		:= $(shell tput -Txterm setaf 3)
LIGHTPURPLE	:= $(shell tput -Txterm setaf 4)
PURPLE		:= $(shell tput -Txterm setaf 5)
BLUE		:= $(shell tput -Txterm setaf 6)
WHITE		:= $(shell tput -Txterm setaf 7)
RESET		:= $(shell tput -Txterm sgr0)

COMPOSE_FILE=./src/docker-compose.yml

all: run

run: 
	@echo "$(GREEN)Building files for volumes ... $(RESET)"
	@echo "$(GREEN)Building containers ... $(RESET)"
	@docker-compose --env-file ./src/.env -f $(COMPOSE_FILE) up -d  --build

up:
	@echo "$(GREEN)Building files for volumes ... $(RESET)"
	@echo "$(GREEN)Building containers in background ... $(RESET)"
	@docker-compose --env-file ./src/.env -f $(COMPOSE_FILE) up -d --build

debug:
	@echo "$(GREEN)Building files for volumes ... $(RESET)"
	@echo "$(GREEN)Building containers with log information ... $(RESET)"
	@docker-compose --env-file ./src/.env -f $(COMPOSE_FILE) up --verbose

list:	
	@echo "$(PURPLE)Listing all containers ... $(RESET)"
	 docker ps -a

list_volumes:
	@echo "$(PURPLE)Listing volumes ... $(RESET)"
	docker volume ls

clean: 	
	@echo "$(RED)Stopping containers ... $(RESET)"
	@docker-compose --env-file ./src/.env -f $(COMPOSE_FILE) down
	@-docker stop `docker ps -qa`
	@-docker rm `docker ps -qa`
	@echo "$(RED)Deleting all images ... $(RESET)"
	@-docker rmi -f `docker images -qa`
	@echo "$(RED)Deleting all volumes ... $(RESET)"
	@-docker volume rm `docker volume ls -q`
	@echo "$(RED)Deleting all network ... $(RESET)"
	@-docker network rm `docker network ls -q`
	@echo "$(RED)Deleting all data ... $(RESET)"
	@echo "$(RED)Deleting all $(RESET)"

.PHONY: run up debug list list_volumes clean
