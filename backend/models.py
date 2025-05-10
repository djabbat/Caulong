# backend/models.py
from sqlalchemy import Column, String, Date, Enum
from sqlalchemy.dialects.postgresql import UUID
import uuid
from database import Base

class User(Base):
    __tablename__ = 'users'

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    email = Column(String, unique=True, index=True, nullable=False)
    hashed_password = Column(String, nullable=False)
    full_name = Column(String)
    birth_date = Column(Date)
    gender = Column(Enum("male", "female", "other", name="gender_enum"), nullable=True)