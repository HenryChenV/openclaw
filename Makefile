OC = node ./openclaw.mjs

all: check_upstream upgrade

check_upstream: fetch_upstream reinstall
	@echo "Upstream looks well."

upgrade: merge_upstram reinstall
	@echo "Upgrade to `openclaw --version`"
	@echo "Enjoy. ^-^"

fetch_upstream:
	git fetch upstream 
	git checkout upstream-main && git reset --hard upstream/main 
	#git clean -fd

reinstall: build doctor gateway_reinstall memory_index

build:
	pnpm install
	pnpm ui:build
	pnpm build

link:
	pnpm link --global

doctor:
	$(OC) doctor
	
gateway_reinstall:
	$(OC) gateway stop
	$(OC) gateway uninstall
	$(OC) gateway install
	$(OC) gateway status
	$(OC) gateway health

merge_upstram:
	git checkout main
	git rebase upstream-main

models_login:
	$(OC) models auth login

memory_index:
	$(OC) memory index

tui:
	$(OC) tui

webui:
	$(OC) dashboard
