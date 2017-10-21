.PHONY: deps format converge verify destroy test kitchen build circleci-build
IMAGE_NAME := qualimente/terraform-infra-dev
IMAGE_TAG := 0.9

FQ_IMAGE := $(IMAGE_NAME):$(IMAGE_TAG)

deps:
	@docker pull $(FQ_IMAGE)

define kitchen
	if [ -z "$(CI)" ]; then \
		docker run --rm -it \
			-e AWS_PROFILE=$(AWS_PROFILE) \
			-e AWS_REGION=$(AWS_REGION) \
			-e AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID) \
			-e AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY) \
			-e AWS_SESSION_TOKEN=$(AWS_SESSION_TOKEN) \
			-e USER=$(USER) \
			-v $(shell pwd):/module \
			-v $(HOME)/.aws:/root/.aws:ro \
			-v $(HOME)/.netrc:/root/.netrc:ro \
			$(FQ_IMAGE) \
			bundle exec kitchen $(1) $(KITCHEN_OPTS); \
	else \
		echo bundle exec kitchen $(1) $(KITCHEN_OPTS); \
		bundle exec kitchen $(1) $(KITCHEN_OPTS); \
	fi;
endef

format:
	@docker run --rm -it \
		-v $(shell pwd):/module \
		$(FQ_IMAGE) \
		terraform fmt

converge:
	@$(call kitchen,converge)

verify:
	@$(call kitchen,verify)

destroy:
	@$(call kitchen,destroy)

test:
	@$(call kitchen,test)

kitchen:
	@$(call kitchen,$(COMMAND))

all: deps format converge verify

circleci-build:
	circleci build \
	-e AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID) \
	-e AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY)
