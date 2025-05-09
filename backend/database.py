from sqlalchemy import create_engine, Column, Integer, String, UUID
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import os

DATABASE_URL = os.getenv("DATABASE_URL")

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()

class Patient(Base):
    __tablename__ = "patients"

    id = Column(UUID, primary_key=True, server_default="gen_random_uuid()")
    first_name = Column(String, nullable=False)
    last_name = Column(String, nullable=False)
    email = Column(String, unique=True, nullable=False)
    phone = Column(String)
    birth_day = Column(Integer)
    birth_month = Column(Integer)
    birth_year = Column(Integer)
    birth_hour = Column(Integer)
    gender = Column(String)

def init_db():
    Base.metadata.create_all(bind=engine)