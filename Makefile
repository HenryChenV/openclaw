update: merge_upstream build doctor reinstall_gateway link
	

merge_upstream:
	git fetch upstream
	git checkout main
	git merge upstream/main

build:
	pnpm install
	pnpm build
	pnpm ui:build # auto-installs UI deps on first run

doctor:
	pnpm openclaw doctor
	pnpm openclaw health

reinstall_gateway:
	pnpm openclaw gateway uninstall
	pnpm openclaw gateway install

link:
	pnpm link --global

dashboard:
	pnpm openclaw dashboard

logs:
	pnpm openclaw logs --follow
