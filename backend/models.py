from sqlalchemy import Column, String, Enum
from sqlalchemy.dialects.postgresql.base import UUID
import uuid
from sqlalchemy.orm import declarative_base

Base = declarative_base()

class User(Base):
    __tablename__ = 'users'
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    email = Column(String, unique=True, index=True)
    full_name = Column(String)
    birth_date = Column(String)
    gender = Column(Enum("male", "female", "other", name="gender_enum"), nullable=True)