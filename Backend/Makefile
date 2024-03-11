SHELL := /bin/bash

.PHONY: build, run*, kill

build:
	docker build -t healtha .
run:
	docker run -p 4000:4000 --name healtha healtha
run-bg:
	docker rm -f healtha
	docker run -p 4000:4000 -d --name healtha healtha
kill:
	docker rm -f healtha
