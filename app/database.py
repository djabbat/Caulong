from typing import AsyncGenerator
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession, async_sessionmaker
from sqlalchemy.orm import declarative_base

DATABASE_URL = "cockroachdb+asyncpg://root@cockroachdb:26257/defaultdb?sslmode=disable"

# Создаём асинхронный движок
engine = create_async_engine(DATABASE_URL, echo=True)

# Создаём асинхронную фабрику сессий
async_session = async_sessionmaker(engine, expire_on_commit=False)

# Базовый класс для моделей
Base = declarative_base()

# Dependency для FastAPI
async def get_async_session() -> AsyncGenerator[AsyncSession, None]:
    async with async_session() as session:
        yield session
