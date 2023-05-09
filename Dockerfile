#

FROM python:3.11.3

WORKDIR /code

COPY ./basic_api_service/requirements.txt /code/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

COPY ./basic_api_service /code/basic_api_service

HEALTHCHECK --interval=5s --timeout=3s CMD curl localhost:80

CMD ["uvicorn", "basic_api_service.main:basic_api_service", "--host", "0.0.0.0", "--port", "80"]
