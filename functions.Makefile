ROOT = $(shell git rev-parse --show-toplevel)
DOCKER_RUN_ROOT=$(ROOT)

export DOCKER_RUN_ROOT

ifndef UPTODATE_GIT_DEFINED
uptodate-git: .scripts/is_up_to_date_with_master.sh
	$(ROOT)/.scripts/is_up_to_date_with_master.sh

UPTODATE_GIT_DEFINED = true
endif

.scripts:
	mkdir $(ROOT)/.scripts

# Get docker_run.py script
.scripts/docker_run.py: .scripts
	wget https://raw.githubusercontent.com/wellcometrust/docker_run/master/docker_run.py -P .scripts
	chmod u+x .scripts/docker_run.py

# Get is_up_to_date_with_master.sh script
.scripts/is_up_to_date_with_master.sh: .scripts
	wget https://raw.githubusercontent.com/wellcometrust/docker_run/master/scripts/is_up_to_date_with_master.sh  -P .scripts
	chmod u+x .scripts/is_up_to_date_with_master.sh

# Get the build scripts required
build_setup: \
	.scripts/is_up_to_date_with_master.sh \
	.scripts/docker_run.py

# Run a 'terraform plan' step.
#
# Args:
#   $1 - Path to the Terraform directory.
#	$2 - true/false: is this a public-facing stack?
#
define terraform_plan
	make uptodate-git build_setup
	$(ROOT)/.scripts/docker_run.py --aws -- \
		--volume $(1):/data \
		--env OP=plan \
		--env GET_TFVARS=false \
		--env bucket_name=wellcomecollection-workflow-infra \
		--env object_key=terraform/workflow.tfvars \
		--env IS_PUBLIC_FACING=$(2) \
		wellcome/terraform_wrapper:latest
endef


# Run a 'terraform apply' step.
#
# Args:
#   $1 - Path to the Terraform directory.
#
define terraform_apply
	make uptodate-git build_setup
	$(ROOT)/.scripts/docker_run.py --aws -- \
		--volume $(1):/data \
		--env OP=apply \
		wellcome/terraform_wrapper:latest
endef
