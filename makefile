.PHONY: pages clean publish
SHELL := /bin/bash
LAST_COMMIT_MESSAGE := $(shell git log -n 1 --pretty=format:'%s')

pages: clean
	./build.sh

clean:
	rm -rf docs/*

publish: pages
	rm -rf ../pages/{*.html,res}
	cp -r docs/* ../pages/
	pushd ../pages/ && \
		git --no-pager diff && \
		git commit -am "$(LAST_COMMIT_MESSAGE)" && \
		git push && \
		popd
