.PHONY: help
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  build    Build the container image."
	@echo "  run      Run the container and access the bash terminal with the current directory mounted."

.PHONY: podman-build
build:
	podman build -f Containerfile -t kali-custom .

.PHONY: podman-run
run:
	podman run -it -v $(CURDIR):/workdir kali-custom

.PHONY: podman
podman: build run

.PHONY: routine
routine:
	bash learning/0002-ssh.sh
