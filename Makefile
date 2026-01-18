REGISTRY=cell
CONTEXT=$(abspath $(shell pwd))
IMAGE=$(notdir ${CONTEXT})
BLAH=${CONTEXT}

.PHONY: build
build:
	docker build -t ${REGISTRY}/${IMAGE} ${CONTEXT}

.PHONY: fresh
fresh:
	docker build --no-cache -t ${REGISTRY}/${IMAGE} ${CONTEXT}

.PHONY: freshest
freshest:
	docker build --pull --no-cache -t ${REGISTRY}/${IMAGE} ${CONTEXT}

.PHONY: push
push:
	docker push ${REGISTRY}/${IMAGE}

