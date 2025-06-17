SHELL := bash
MAKEFLAGS += --no-print-directory

PRG := gostty


help: # Print help on Makefile
	@echo -e "\nPlease use 'make <target>' where <target> is one of:\n"
	@grep '^[^.#]\+:\s\+.*#' Makefile | \
	  sed "s/\(.\+\):\s*\(.*\) #\s*\(.*\)/`printf "\033[93m"`  \1`printf "\033[0m"`\t\3/" | \
	  column -s $$'\t' -t
	@echo -e "\nCheck the Makefile to know exactly what each target is doing.\n"

.PHONY: clean
clean:  # remove artefacts
	docker rmi $(PRG):latest &>/dev/null || true
	rm -f $(PRG)
	@echo ""

.PHONY: build
build: # Build binary in Docker using the Dockerfile
	docker build -t $(PRG) .
	@echo ""
	@docker images $(PRG)


.PHONY: extract
extract: # extract binary from the docker container image
	@docker images | grep -qE '$(PRG)\s+latest' || ( echo -e "\nERROR: image $(PRG):latest not found\n"; exit 1 )
	@docker create --name $(PRG)_extract $(PRG):latest >/dev/null
	@docker cp $(PRG)_extract:/$(PRG) ./$(PRG) &>/dev/null
	@docker rm $(PRG)_extract &>/dev/null
	@echo -e "\nExtracted binary: \e[1;32m./$(PRG)\e[0;m\n"

.PHONY: all
all: clean build extract # Clean, build and extract binary


.PHONY: clean-all
clean-all: clean # remove artefacts and clean BuildKit cache
	docker buildx prune -a -f
	@echo ""
