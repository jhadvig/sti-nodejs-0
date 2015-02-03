
ifeq ($(TARGET),rhel7)
	IMAGE_NAME := nodejs-0-rhel7
else
	IMAGE_NAME := nodejs-0-centos7
endif


build:
ifeq ("$(TARGET)","rhel7")
	mv Dockerfile Dockerfile.centos
	mv Dockerfile.rhel7 Dockerfile
	docker build -t $(IMAGE_NAME) .
	mv Dockerfile Dockerfile.rhel
	mv Dockerfile.centos Dockerfile
else 
	docker build -t $(IMAGE_NAME) .
endif


.PHONY: test
test:
ifeq ($(TARGET),rhel7)
	mv Dockerfile Dockerfile.centos
	mv Dockerfile.rhel7 Dockerfile
	docker build -t $(IMAGE_NAME)-candidate .
	IMAGE_NAME=$(IMAGE_NAME)-candidate test/run
	mv Dockerfile Dockerfile.rhel
	mv Dockerfile.centos Dockerfile
else
	docker build -t $(IMAGE_NAME)-candidate .
	IMAGE_NAME=$(IMAGE_NAME)-candidate test/run
endif