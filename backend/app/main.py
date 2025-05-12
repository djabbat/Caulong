from fastapi import FastAPI
from .database import Base, engine
from . import models

app = FastAPI()

@app.get("/")
def read_root():
    return {"Hello": "World"}