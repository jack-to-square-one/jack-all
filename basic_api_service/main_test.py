from fastapi.testclient import TestClient
from main import basic_api_service, TITLE_MESSAGE, DEFAULT_TIMEZONE
from freezegun import freeze_time
from datetime import datetime
from http import HTTPStatus
import pytz

client = TestClient(basic_api_service)


def test_root_message():
    response = client.get("/")
    assert response.status_code == HTTPStatus.OK
    assert response.json()["message"] == TITLE_MESSAGE


@freeze_time("2023-01-01 00:00:00")
def test_get_time_and_date():
    expected_response = "13:00:00 01/01/2023"
    response = client.get("/time")
    assert response.status_code == HTTPStatus.OK
    assert response.json()[f"Time in {DEFAULT_TIMEZONE}"] == expected_response


@freeze_time("2023-01-01 00:00:00")
def test_get_time_and_date_with_timezone():
    test_timezone = "Europe/London"
    expected_response = "00:00:00 01/01/2023"
    response = client.get("/time/?timezone=" + test_timezone)
    assert response.status_code == HTTPStatus.OK
    assert response.json()[f"Time in {test_timezone}"] == expected_response
