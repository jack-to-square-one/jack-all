docker_port := 5000
service_name := basic_api_service
service_tag := basicapiservice
service_dir := basic_api_service

all: init lint test docker-build docker-start verify-service

docker-build:
	docker build --tag ${service_tag} .

docker-start:
	docker run --detach --name ${service_name} --publish ${docker_port}:${docker_port} ${service_tag}
	./wait-for-healthy-container/wait-for-healthy-container.sh basic_api_service

docker-stop:
	docker stop ${service_name}
	docker rm ${service_name}

docker-verify-service:
	curl --retry 3 --retry-max-time 20 -X GET localhost:${docker_port}/time

init:
	python -m pip install --upgrade pip
	cd ${service_dir} && python -m pip install -r requirements.txt
	cd ${service_dir} && python -m pip install -r requirements-dev.txt
	chmod +x wait-for-healthy-container/wait-for-healthy-container.sh

k8s-cluster-start:
	minikube start
	eval $(minikube docker-env)

k8s-deploy:
	kubectl apply -f basic-api-deployment.yaml

k8s-delete:
	kubectl delete -f basic-api-deployment.yaml

k8s-verify-service:
	curl http://$(shell minikube ip):$(shell kubectl get services/basic-api-service-service -o go-template='{{(index .spec.ports 0).nodePort}}')/time

lint:
	black --color .

lint-check:
	docker run --volume $(shell pwd):/src --workdir /src pyfound/black:latest_release black --check .

run:
	uvicorn main:${service_name} --app-dir ${service_dir} --reload

test:
	pytest

