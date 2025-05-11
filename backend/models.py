# models.py
from database import Base
from sqlalchemy import Column, Integer, String, Date

class Patient(Base):
    __tablename__ = "patients"

    id = Column(Integer, primary_key=True)
    name = Column(String)
    gender = Column(String(10))
    birth_date = Column(Date)
    user_id = Column(String, unique=True)