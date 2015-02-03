
if [ $(TARGET) == "rhel7" ]; then
	IMAGE_NAME = nodejs-0-rhel7
else
	IMAGE_NAME = nodejs-0-centos7
fi

build:
	if [ $(TARGET) == "rhel7" ]; then
		mv Dockerfile Dockerfile.centos
		mv Dockerfile.rhel7 Dockerfile
		docker build -t $(IMAGE_NAME) .
		mv Dockerfile Dockerfile.rhel
		mv Dockerfile.centos Dockerfile
	else 
		docker build -t $(IMAGE_NAME) .
	fi

.PHONY: test
test:
	if [ $(TARGER) == "rhel7" ]; then
		mv Dockerfile Dockerfile.centos
		mv Dockerfile.rhel7 Dockerfile
		docker build -t $(IMAGE_NAME)-candidate .
		IMAGE_NAME=$(IMAGE_NAME)-candidate test/run
		mv Dockerfile Dockerfile.rhel
		mv Dockerfile.centos Dockerfile
	else
		docker build -t $(IMAGE_NAME)-candidate .
		IMAGE_NAME=$(IMAGE_NAME)-candidate test/run
	fi