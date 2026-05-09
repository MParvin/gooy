SERVER     := gooy
REMOTE_DIR := /opt/src/gooy/
PUBLIC_DIR := ./public

.DEFAULT_GOAL := deploy
.PHONY: help build deploy clean preview all cache-remove
help:
	@echo ""
	@echo "Usage: make <target>"
	@echo ""
	@grep -E '^## ' Makefile | sed 's/## /  /'
	@echo ""

build: clean cache-remove
	hugo --minify --gc --cleanDestinationDir

preview: build
	firefox http://localhost:1313/
	hugo server --buildDrafts --buildFuture --disableFastRender --openBrowser --ignoreCache -p 1313

deploy: build
	rsync -avz --delete \
		--exclude='.DS_Store' \
		$(PUBLIC_DIR)/ $(SERVER):$(REMOTE_DIR)
	@echo "✓ Deployed to $(SERVER):$(REMOTE_DIR)"
	firefox gooy.site

cache-remove:
	rm -rf ./resources/_gen
	rm -f ./.hugo_build.lock
	@echo "✓ Hugo cache cleared"

clean:
	rm -rf $(PUBLIC_DIR)
	@echo "✓ Cleaned public/"

