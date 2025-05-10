# backend/database.py
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker, declarative_base
from sqlalchemy import MetaData

DATABASE_URL = "postgresql+asyncpg://root@cockroach:26257/caulong_db?sslmode=disable"

engine = create_async_engine(DATABASE_URL, echo=True)
AsyncDBSession = sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)

Base = declarative_base()
metadata = MetaData()