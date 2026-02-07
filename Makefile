update: merge_upstream build link doctor reinstall_gateway
	

merge_upstream:
	git fetch upstream
	git checkout main
	git merge upstream/main

build:
	pnpm install
	pnpm build
	pnpm ui:build # auto-installs UI deps on first run

link:
	pnpm link --global

doctor:
	openclaw doctor
	openclaw health

reinstall_gateway:
	openclaw gateway uninstall
	openclaw gateway install

dashboard:
	openclaw dashboard

logs:
	openclaw logs --follow
