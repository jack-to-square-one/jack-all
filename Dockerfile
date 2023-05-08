#

FROM python:3.11.3

WORKDIR /code

COPY ./basic_api_service/requirements.txt /code/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

COPY ./basic_api_service /code/basic_api_service

CMD ["uvicorn", "basic_api_service.main:basic_api_service", "--host", "0.0.0.0", "--port", "80"]
