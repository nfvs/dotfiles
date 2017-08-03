#!/usr/bin/env sh

docker-images-dangling() {
	docker images "$@" --filter "dangling=true"
}

docker-images-dangling-remove() {
    docker-images-dangling --quiet | xargs docker "$@" rmi;
}

docker-containers-stopped() {
	docker ps "$@" -a --filter 'exited=0'
}

docker-containers-stopped-remove() {
	docker-containers-stopped --quiet | xargs docker "$@" rm;
}
