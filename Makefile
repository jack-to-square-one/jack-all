service_name := basic_api_service
service_tag := basicapiservice
service_dir := basic_api_service

init:
	cd ${service_dir} && python -m pip install -r requirements.txt
	python -m pip install black
	python -m pip install pytest
	python -m pip install httpx
	python -m pip install freezegun

run:
	uvicorn main:${service_name} --app-dir ${service_dir} --reload

lint:
	black .

test:
	pytest

docker-build:
	docker build --tag ${service_tag} .

docker-run:
	docker run -detach --name ${service_name} --publish 80:80 ${service_tag}

docker-stop:
	docker stop ${service_name}
	docker rm ${service_name}
