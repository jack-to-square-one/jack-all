init:
	cd basic_api_service && python -m pip install -r requirements.txt
	python -m pip install black
	python -m pip install pytest
	python -m pip install httpx
	python -m pip install freezegun

run:
	uvicorn main:basic_api_service --app-dir basic_api_service --reload

lint:
	black .

test:
	pytest
