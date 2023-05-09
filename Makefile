port := 80
service_name := basic_api_service
service_tag := basicapiservice
service_dir := basic_api_service

all: init lint test docker-build docker-start verify-service

docker-build:
	docker build --tag ${service_tag} .

docker-start:
	docker run --detach --name ${service_name} --publish ${port}:${port} ${service_tag}
	./wait-for-healthy-container/wait-for-healthy-container.sh basic_api_service

docker-stop:
	docker stop ${service_name}
	docker rm ${service_name}

init:
	python -m pip install --upgrade pip
	cd ${service_dir} && python -m pip install -r requirements.txt
	python -m pip install black
	python -m pip install pytest
	python -m pip install httpx
	python -m pip install freezegun
	chmod +x wait-for-healthy-container/wait-for-healthy-container.sh

lint:
	black --color .

lint-check:
	docker run --volume $(shell pwd):/src --workdir /src pyfound/black:latest_release black --check .

run:
	uvicorn main:${service_name} --app-dir ${service_dir} --reload

test:
	pytest

verify-service:
	curl --retry 3 --retry-max-time 20 -X GET localhost:${port}/time
