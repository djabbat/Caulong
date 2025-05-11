# main.py
from fastapi import FastAPI
from sqlalchemy.ext.asyncio import AsyncSession
from database import engine, Base
from models import Patient

app = FastAPI()

@app.on_event("startup")
async def setup_database():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

@app.get("/")
async def read_root():
    return {"message": "Welcome to Caulong API"}