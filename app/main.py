from fastapi import FastAPI
from database import Base, engine

app = FastAPI()

@app.on_event("startup")
async def setup_database():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

@app.get("/")
def read_root():
    return {"message": "FastAPI запущен в production-режиме"}