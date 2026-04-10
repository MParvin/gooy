SERVER     := gooy
REMOTE_DIR := /var/www/html/
PARVIN_REMOTE_DIR := /var/www/mparvin/
PUBLIC_DIR := ./public

.PHONY: help build deploy clean preview mparvin all
all: mparvin deploy
	@echo "✓ Ran mparvin and deploy targets"

help:
	@echo ""
	@echo "Usage: make <target>"
	@echo ""
	@grep -E '^## ' Makefile | sed 's/## /  /'
	@echo ""

build:
	hugo --minify --gc --cleanDestinationDir

preview:
	hugo server --buildDrafts --buildFuture --disableFastRender --openBrowser

deploy: build
	rsync -avz --delete \
		--exclude='.DS_Store' \
		$(PUBLIC_DIR)/ $(SERVER):$(REMOTE_DIR)
	@echo "✓ Deployed to $(SERVER):$(REMOTE_DIR)"

clean:
	rm -rf $(PUBLIC_DIR)
	@echo "✓ Cleaned public/"

mparvin:
	cp hugo_mparvin.toml hugo.toml
	hugo --minify --gc --cleanDestinationDir
	cp hugo_gooy.toml hugo.toml
	rsync -avz --delete \
		--exclude='.DS_Store' \
		$(PUBLIC_DIR)/ $(SERVER):$(PARVIN_REMOTE_DIR)
	@echo "✓ Deployed to $(SERVER):$(PARVIN_REMOTE_DIR)"
