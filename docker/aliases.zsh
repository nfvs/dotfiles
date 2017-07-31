drmui() {
    docker rmi $@ $(docker images | grep '<none>' | awk '{print $3}');
}

drmc() {
	docker ps -a | grep 'weeks ago\|months ago' | awk '{print $1}' | xargs docker rm
}

dockerps() {
    docker ps | sed -n 2p | awk '{print $1}'
}

dockerexec() {
    sudo docker exec -it $(sudo docker ps | sed -n 2p | awk '{print $1}') bash
}
