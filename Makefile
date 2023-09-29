IMAGE_NAME=docker.io/goforbroke1006/bitnami-clickhouse:22.3.20-debian-11-r16

publish:
	docker build -f ./Dockerfile -t ${IMAGE_NAME} .
	docker login
	docker push ${IMAGE_NAME}
