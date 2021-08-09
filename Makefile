REGISTRY=cell
CONTEXT=$(abspath $(shell pwd))
IMAGE=$(notdir ${CONTEXT})
BLAH=${CONTEXT}


build:
	docker build -t ${REGISTRY}/${IMAGE} ${CONTEXT}
.PHONY: build

build-fresh:
	docker build --pull -t ${REGISTRY}/${IMAGE} ${CONTEXT}
.PHONY: build-fresh

push:
	docker push ${REGISTRY}/${IMAGE}
.PHONY: push

