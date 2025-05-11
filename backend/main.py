from fastapi import FastAPI
from pydantic import BaseModel
from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine
from sqlalchemy.orm import declarative_base, sessionmaker

app = FastAPI()

# === БАЗА ДАННЫХ ===
DATABASE_URL = "postgresql+asyncpg://root@cockroach:26257/caulong_db?sslmode=disable"

Base = declarative_base()

engine = create_async_engine(DATABASE_URL)
AsyncSessionLocal = sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)

@app.get("/health")
def health_check():
    return {"status": "healthy"}