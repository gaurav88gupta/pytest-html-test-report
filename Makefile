SHELL  := /bin/bash
RED    := \033[0;31m
GREEN  := \033[0;32m
CYAN   := \033[0;36m
YELLOW := \033[1;33m
NC     := \033[0m # No Color

PATH       := ${PATH}:${HOME}/.local/bin
PYTHONPATH := .:src/lib/python3.6/site-package

usage:
	  @printf "${YELLOW}make tools             ${GREEN}# Setup virtualenv.${NC}\n"
		@printf "${YELLOW}make init              ${GREEN}# Install env dependencies.${NC}\n"
		@printf "${YELLOW}make clean             ${GREEN}# Clean dependencies.${NC}\n"
		@printf "${YELLOW}make preprocess-data   ${GREEN}# Preprocess data.${NC}\n"
		@printf "${YELLOW}make create-db         ${GREEN}# Create database.${NC}\n"
		@printf "${YELLOW}make create-tables     ${GREEN}# Create tables.${NC}\n"
		@printf "${YELLOW}make ingest-data       ${GREEN}# Ingest Data.${NC}\n"
		@printf "${YELLOW}make query-data        ${GREEN}# Run sample queries on your data.${NC}\n"
		@printf "${YELLOW}make all               ${GREEN}# Run all at once${NC}\n"
		@printf "${YELLOW}make functional        ${GREEN}# Run functional tests${NC}\n"
		@printf "\n"


tools:
	pip3 install pythonenv virtualenv

init: tools
	mkdir -p src && \
	cd src && \
	virtualenv . --always-copy --python=python3 && \
	source ./bin/activate && \
	pip3 install --no-cache-dir -r ../requirements.txt

activate:
	source src/bin/activate

preprocess-data: activate
	python3 -m src.preprocess_data

create-db: activate
	python3 -m src.create_db

create-tables: activate
	python3 -m src.create_tables

ingest-data: activate
	python3 -m src.ingest_data

query-data: activate
	python3 -m src.query_data

all: init preprocess-data create-db create-tables ingest-data

functional: activate
	pytest --html=report.html
