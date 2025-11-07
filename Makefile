.PHONY: help
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  podman-build    Build the container image."
	@echo "  podman-run      Run the container and access the bash terminal with the current directory mounted."

.PHONY: podman-build
podman-build:
	podman build -f Containerfile -t kali-custom .

.PHONY: podman-run
podman-run:
	podman run -it -v $(CURDIR):/workdir kali-custom

.PHONY: podman
podman: podman-build podman-run

.PHONY: run
run:
	bash learning/001-sha.sh
