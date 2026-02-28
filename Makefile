OC = ./openclaw.mjs

all: check_upstream upgrade

check_upstream: fetch_upstream install
	@echo "Upstream looks well."

upgrade: merge_upstram install
	@echo "Upgrade to `openclaw --version`"
	@echo "Enjoy. ^-^"

fetch_upstream:
	git fetch upstream 
	git checkout upstream-main && git reset --hard upstream/main 
	#git clean -fd

install: build doctor reinstall_gateway

build:
	pnpm install
	pnpm ui:build
	pnpm build

link:
	pnpm link --global

doctor:
	$(OC) doctor
	
reinstall_gateway:
	$(OC) gateway stop
	$(OC) gateway uninstall
	$(OC) gateway install
	$(OC) gateway status
	$(OC) gateway health

merge_upstram:
	git checkout main
	git rebase upstream-main
