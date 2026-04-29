SERVER     := gooy
REMOTE_DIR := /var/www/html/
PARVIN_REMOTE_DIR := /var/www/gooy/
PUBLIC_DIR := ./public

.DEFAULT_GOAL := deploy
.PHONY: help build deploy clean preview all
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

