FROM python:3.11.3-slim

RUN apt-get -y update && apt-get -y install curl

WORKDIR /code

COPY ./basic_api_service/requirements.txt /code/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

COPY ./basic_api_service/main.py /code/main.py

HEALTHCHECK --interval=5s --timeout=3s CMD curl localhost:5000

CMD ["uvicorn", "main:basic_api_service", "--host", "0.0.0.0", "--port", "5000"]
