all:
	@docker compose -f ./scrs/docker-compose.yml up -d --build

down:
	@docker compose -f ./scrs/docker-compose.yml down

re:
	@docker compose -f scrs/docker-compose.yml up -d --build

clean:
	@docker stop $$(docker ps -qa);\
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm $$(docker volume ls -q);\
	docker network rm $$(docker network ls -q);\

.PHONY: all re down clean

# BLACK		:= $(shell tput -Txterm setaf 0)
# RED		:= $(shell tput -Txterm setaf 1)
# GREEN		:= $(shell tput -Txterm setaf 2)
# YELLOW		:= $(shell tput -Txterm setaf 3)
# LIGHTPURPLE	:= $(shell tput -Txterm setaf 4)
# PURPLE		:= $(shell tput -Txterm setaf 5)
# BLUE		:= $(shell tput -Txterm setaf 6)
# WHITE		:= $(shell tput -Txterm setaf 7)
# RESET		:= $(shell tput -Txterm sgr0)

# COMPOSE_FILE=./srcs/docker-compose.yml

# all: run

# run: 
# 	@echo "$(GREEN)Building files for volumes ... $(RESET)"
# 	@sudo mkdir -p /home/llescure/data/wordpress
# 	@sudo mkdir -p /home/llescure/data/mysql
# 	@echo "$(GREEN)Building containers ... $(RESET)"
# 	@docker-compose -f $(COMPOSE_FILE) up --build

# up:
# 	@echo "$(GREEN)Building files for volumes ... $(RESET)"
# 	@sudo mkdir -p /home/llescure/data/wordpress
# 	@sudo mkdir -p /home/llescure/data/mysql
# 	@echo "$(GREEN)Building containers in background ... $(RESET)"
# 	@docker-compose -f $(COMPOSE_FILE) up -d --build

# debug:
# 	@echo "$(GREEN)Building files for volumes ... $(RESET)"
# 	@sudo mkdir -p /home/llescure/data/wordpress
# 	@sudo mkdir -p /home/llescure/data/mysql
# 	@echo "$(GREEN)Building containers with log information ... $(RESET)"
# 	@docker-compose -f $(COMPOSE_FILE) --verbose up

# list:	
# 	@echo "$(PURPLE)Listing all containers ... $(RESET)"
# 	 docker ps -a

# list_volumes:
# 	@echo "$(PURPLE)Listing volumes ... $(RESET)"
# 	docker volume ls

# clean: 	
# 	@echo "$(RED)Stopping containers ... $(RESET)"
# 	@docker-compose -f $(COMPOSE_FILE) down
# 	@-docker stop `docker ps -qa`
# 	@-docker rm `docker ps -qa`
# 	@echo "$(RED)Deleting all images ... $(RESET)"
# 	@-docker rmi -f `docker images -qa`
# 	@echo "$(RED)Deleting all volumes ... $(RESET)"
# 	@-docker volume rm `docker volume ls -q`
# 	@echo "$(RED)Deleting all network ... $(RESET)"
# 	@-docker network rm `docker network ls -q`
# 	@echo "$(RED)Deleting all data ... $(RESET)"
# 	@sudo rm -rf /home/llescure/data/wordpress
# 	@sudo rm -rf /home/llescure/data/mysql
# 	@echo "$(RED)Deleting all $(RESET)"

# .PHONY: run up debug list list_volumes clean