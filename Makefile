GITHUB_USER ?= podtato-head

install-requirements:
	scripts/requirements.sh /usr/local/bin

### podtato-head-microservices

build-microservices-images:
	podtato-head-microservices/build/build_images.sh

push-microservices-images:
	PUSH_TO_REGISTRY=1 podtato-head-microservices/build/build_images.sh

test-microservices:
	podtato-head-microservices/build/test_services.sh

.PHONY: build-microservices-images push-microservices-images test-microservices install-requirements 
