ROOT = $(shell git rev-parse --show-toplevel)

ifndef UPTODATE_GIT_DEFINED

# This target checks if you're up-to-date with the current master.
# This avoids problems where Terraform goes backwards or breaks
# already-applied changes.
#
# Consider the following scenario:
#
#     * --- * --- X --- Z                 master
#                  \
#                   Y --- Y --- Y         feature branch
#
# We cut a feature branch at X, then applied commits Y.  Meanwhile master
# added commit Z, and ran `terraform apply`.  If we run `terraform apply` on
# the feature branch, this would revert the changes in Z!  We'd rather the
# branches looked like this:
#
#     * --- * --- X --- Z                 master
#                        \
#                         Y --- Y --- Y   feature branch
#
# So that the commits in the feature branch don't unintentionally revert Z.
#
uptodate-git:
	@git fetch origin
	@if ! git merge-base --is-ancestor origin/master HEAD; then \
		echo "You need to be up-to-date with master before you can continue!"; \
		exit 1; \
	fi

UPTODATE_GIT_DEFINED = true

endif

# Run a 'terraform plan' step.
#
# Args:
#   $1 - Path to the Terraform directory.
#	$2 - true/false: is this a public-facing stack?
#
define terraform_plan
	make uptodate-git
	AWS_PROFILE="workflow" $(ROOT)/docker_run.py --aws -- \
		--volume $(1):/data \
		--env OP=plan \
		--env GET_TFVARS=true \
		--env IS_PUBLIC_FACING=$(2) \
		--env BUCKET_NAME=wellcomecollection-workflow-infra \
		--env OBJECT_KEY=terraform/workflow.tfvars \
		wellcome/terraform_wrapper:latest
endef


# Run a 'terraform apply' step.
#
# Args:
#   $1 - Path to the Terraform directory.
#
define terraform_apply
	make uptodate-git
	AWS_PROFILE="workflow" $(ROOT)/docker_run.py --aws -- \
		--volume $(1):/data \
		--env OP=apply \
		--env BUCKET_NAME=wellcomecollection-workflow-infra \
		--env OBJECT_KEY=terraform/workflow.tfvars \
		wellcome/terraform_wrapper:latest
endef
