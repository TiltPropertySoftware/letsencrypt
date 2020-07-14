ifneq (,)
.error This Makefile requires GNU Make.
endif

.PHONY: hooks validate changelog image install_tools

help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

hooks: ## Commit hooks setup
	@pre-commit install
	@pre-commit gc
	@pre-commit autoupdate

validate: ## Validate files with pre-commit hooks
	@pre-commit run --all-files

changelog:
	git-chglog -o CHANGELOG.md

install_tools:
	@brew install pre-commit
	@brew tap git-chglog/git-chglog
	@brew install git-chglog

image:
	./build.sh
