from typing import List
from fastapi import FastAPI
import uvicorn as uvicorn
from dynaconf import settings
from application import faker_app

app = FastAPI()

app.include_router(faker_app.router)

uvicorn.run(app, host=settings.HOST, port=settings.PORT)
