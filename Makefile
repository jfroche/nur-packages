.DEFAULT_GOAL:=help

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

install-git-hooks:  ## Install git hooks (pre-commit, pre-push, commit-msg)
	@pre-commit install -f -t commit-msg
	@pre-commit install -f -t pre-push
	@npre-commit install -f -t pre-commit

test:  ## Run tests
	pre-commit run --all
	NIX_PATH="" nix-instantiate ci.nix


