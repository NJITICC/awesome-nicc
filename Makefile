# requirements: git bash make python3-pip python3-venv
SHELL := /bin/bash
ifeq ($(OS),Windows_NT)
  ACTIVATE_PATH := .venv/Scripts/activate
else
  ACTIVATE_PATH := .venv/bin/activate
endif

.PHONY: install # install build tools in a virtualenv
install:
	python3 -m venv .venv
	source $(ACTIVATE_PATH) && \
	pip3 install wheel && \
	pip3 install --force ./hecat

.PHONY: awesome_lint # check data against awesome-nicc guidelines
awesome_lint:
	source $(ACTIVATE_PATH) && \
	hecat --config .hecat/awesome-lint.yml

.PHONY: export_markdown # render markdown export from YAML data
export_markdown:
	source $(ACTIVATE_PATH) && hecat --config .hecat/export-markdown.yml

.PHONY: export_html # render HTML export from YAML data (https://njiticc.github.io/awesome-nicc)
export_html:
	rm -rf html/
	mkdir html && source $(ACTIVATE_PATH) && hecat --config .hecat/export-html.yml
	source $(ACTIVATE_PATH) && sphinx-build -b html -c .hecat/ html/md/ html/html/
	rm -rf html/html/.buildinfo html/html/objects.inv html/html/.doctrees

.PHONY: push_markdown # commit and push changes to the markdown repository
push_markdown:
	$(eval COMMIT_HASH=$(shell git rev-parse --short HEAD))
	git config user.name github-actions[bot] && git config user.email 41898282+github-actions[bot]@users.noreply.github.com
	git add README.md && (git diff-index --quiet HEAD || git commit -m "chore: build markdown from data $(COMMIT_HASH)")
	git push

.PHONY: url_check # check URLs for dead links or other connection problems
url_check:
	source $(ACTIVATE_PATH) && \
	hecat --config .hecat/url-check.yml

.PHONY: clean # clean files generated by automated tasks
clean:
	rm -rf html/ .venv/

.PHONY: help # generate list of targets with descriptions
help:
	@grep '^.PHONY: .* #' Makefile | sed 's/\.PHONY: \(.*\) # \(.*\)/\1	\2/' | expand -t20
