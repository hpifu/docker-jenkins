version=$(shell git describe --tags)
repository=jenkins
user=hatlonely

.PHONY: deploy remove build push

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
	sedi=sed -i ""
else
	sedi=sed -i
endif

deploy:
	mkdir -p /var/docker/${repository}/data
	# chown -R 1000:1000 /var/docker/${repository}/data
	docker stack deploy -c stack.yml ${repository}

remove:
	docker stack rm ${repository}

build:
	docker build --tag=${user}/${repository}:${version} .
	cat stack.tpl.yml | sed 's/\$${version}/${version}/g' | sed 's/\$${repository}/${repository}/g' > stack.yml

push:
	docker push ${user}/${repository}:${version}

passwd:
	docker exec $$(docker ps --filter name=$(repository) -q) cat /var/jenkins_home/secrets/initialAdminPassword

logs:
	docker logs $$(docker ps --filter name=$(repository) -q)
