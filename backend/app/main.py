from fastapi import FastAPI
from .database import Base, engine, create_tables
from . import models

app = FastAPI()

@app.on_event("startup")
async def startup_event():
    create_tables()  # Создаем таблицы при старте

@app.get("/")
def read_root():
    return {"status": "Database initialized"}