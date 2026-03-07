OC = node ./openclaw.mjs

all:
	$(MAKE) check_upstream
	$(MAKE) upgrade

check_upstream: fetch_upstream reinstall
	git checkout main
	@echo "Upstream looks well."

upgrade: merge_upstream reinstall
	@echo "Upgrade to `$(OC) --version`"
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
	
gateway_restart:
	$(OC) gateway restart
	$(OC) gateway status
	$(OC) gateway health

merge_upstream:
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
