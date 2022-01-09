# paketobuildpacks/builder:base
BUILDER = paketobuildpacks/builder@sha256:7308b52dc7dfd9ef2d1874ae905b44d489b1867bdb9c3c6fd21c28f941437abd

#IMAGE = localhost:5000/buildpack-test/sample-app
IMAGE = sample-app

CACHE_OPTS = --cache-image localhost:5000/buildpack-test/sample-app:cache --publish --network host

#COMMON_OPTS = --clear-cache
#COMMON_OPTS = $(CACHE_OPTS)
COMMON_OPTS = 

.PHONY: clean
clean:
	rm -rf sample-app/node_modules sample-app/dist
	docker image rm sample-app

.PHONY: build-legacy
build-legacy:
	docker build -f legacy/Dockerfile -t buildpack-test sample-ts-app


.PHONY: build-ts
build-ts:
	pack build $(COMMON_OPTS) $(IMAGE) --path sample-ts-app --builder $(BUILDER)

.PHONY: build-nodejs
build-nodejs:
	pack build $(COMMON_OPTS) $(IMAGE) --path sample-nodejs-app --builder $(BUILDER)


.PHONY: inspect-image-build-metadata
inspect-image-build-metadata:
	@docker image inspect sample-ts-app | jq -r '.[0].Config.Labels."io.buildpacks.build.metadata"'

.PHONY: inspect-image-oci-labels
inspect-image-oci-labels:
	@docker image inspect sample-ts-app | jq -r '.[0].Config.Labels | to_entries[] | select(.key|startswith("org.opencontainers")) | .'

.PHONY: bom
bom:
	pack inspect --bom sample-app

.PHONY: builder-inspect
builder-inspect:
	pack builder inspect paketobuildpacks/builder:base


.PHONY: local-registry-start
local-registry-start:
	docker run --rm -d -p 5000:5000 --name registry registry:2

.PHONY: local-registry-stop
local-registry-stop:
	docker container stop registry
