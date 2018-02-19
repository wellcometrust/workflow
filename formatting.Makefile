ROOT = $(shell git rev-parse --show-toplevel)

format-terraform:
	$(ROOT)/builds/docker_run.py --aws -- \
		--volume $(ROOT):/repo \
		--workdir /repo \
		hashicorp/terraform:light fmt

travis-format: format-terraform
