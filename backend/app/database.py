from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import os

# Автоматическое создание таблиц при старте
def create_tables():
    Base.metadata.create_all(bind=engine)

SQLALCHEMY_DATABASE_URL = os.getenv("DATABASE_URL", "cockroachdb+psycopg2://root@cockroachdb:26257/caulong_db?sslmode=disable")

engine = create_engine(SQLALCHEMY_DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()