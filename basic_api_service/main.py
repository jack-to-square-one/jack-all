from fastapi import FastAPI
from datetime import datetime
import pytz

TITLE_MESSAGE = "Very simple time teller"
TIME_FORMAT = "%H:%M:%S %m/%d/%Y"
DEFAULT_TIMEZONE = "Pacific/Auckland"

basic_api_service = FastAPI()


@basic_api_service.get("/")
async def root():
    return {"message": TITLE_MESSAGE}


@basic_api_service.get("/time")
async def get_time_and_date(timezone: str = DEFAULT_TIMEZONE):
    return {f"Time in {timezone}": time_and_date(timezone)}


def time_and_date(timezone: str):
    now = datetime.now(pytz.timezone(timezone))
    return now.strftime(TIME_FORMAT)
