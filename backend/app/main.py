from fastapi import FastAPI
from .database import Base, engine, create_tables
from . import models
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

@app.on_event("startup")
async def startup_event():
    create_tables()  # Создаем таблицы при старте

@app.get("/")
def read_root():
    return {"status": "Database initialized"}

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # или указать конкретные домены
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)