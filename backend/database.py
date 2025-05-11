from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import os

DATABASE_URL = os.getenv(
    "DATABASE_URL", 
    "cockroachdb+psycopg2://root@cockroachdb:26257/defaultdb?sslmode=disable"
)

engine = create_engine(
    DATABASE_URL,
    pool_pre_ping=True,
    echo=True
)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()