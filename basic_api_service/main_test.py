from fastapi.testclient import TestClient
from main import (
    basic_api_service,
    time_and_date,
    TITLE_MESSAGE,
    TIME_FORMAT,
    DEFAULT_TIMEZONE,
)
from freezegun import freeze_time
from datetime import datetime
import pytz

client = TestClient(basic_api_service)


def test_root_message():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json()["message"] == TITLE_MESSAGE


@freeze_time("2023-01-01 00:00:00")
def test_get_time_and_date():
    response = client.get("/time")
    expected_response = time_and_date(DEFAULT_TIMEZONE)
    assert response.status_code == 200
    assert response.json()["Time in Pacific/Auckland"] == expected_response


@freeze_time("2023-01-01 00:00:00")
def test_get_time_and_date_with_timezone():
    test_timezone = "Europe/London"
    response = client.get("/time/?timezone=" + test_timezone)
    expected_response = time_and_date(test_timezone)
    assert response.status_code == 200
    assert response.json()["Time in Europe/London"] == expected_response
