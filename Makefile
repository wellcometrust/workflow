include functions.Makefile
include formatting.Makefile

tf-plan:
	$(call terraform_plan,$(ROOT),false)

tf-apply:
	$(call terraform_apply,$(ROOT))