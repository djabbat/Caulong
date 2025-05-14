# app/schemas.py

from pydantic import BaseModel, EmailStr, Field, validator
from datetime import datetime
import uuid
from typing import Optional

class UserBase(BaseModel):
    """Базовая модель пользователя"""
    username: str = Field(..., min_length=3, max_length=50, example="ivan_ivanov")
    email: EmailStr = Field(..., example="user@example.com")

class UserCreate(UserBase):
    """Модель для создания пользователя (включая пароль)"""
    password: str = Field(..., min_length=8, max_length=100, example="strongpassword123")

    @validator('username')
    def username_alphanumeric(cls, v):
        if not v.isalnum():
            raise ValueError('Имя пользователя должно содержать только буквы и цифры')
        return v

    @validator('password')
    def password_complexity(cls, v):
        if len(v) < 8:
            raise ValueError('Пароль должен быть не менее 8 символов')
        # Дополнительные проверки сложности пароля можно добавить здесь
        return v

class UserUpdate(BaseModel):
    """Модель для обновления данных пользователя"""
    username: Optional[str] = Field(None, min_length=3, max_length=50)
    email: Optional[EmailStr] = Field(None)
    password: Optional[str] = Field(None, min_length=8, max_length=100)

class UserLogin(BaseModel):
    """Модель для входа пользователя"""
    username: str = Field(..., example="ivan_ivanov")
    password: str = Field(..., example="strongpassword123")

class UserResponse(UserBase):
    """Модель ответа с данными пользователя (без пароля)"""
    id: uuid.UUID
    created_at: datetime
    is_active: bool = Field(default=True)

    class Config:
        from_attributes = True  # Ранее known as orm_mode
        json_encoders = {
            datetime: lambda v: v.isoformat(),
            uuid.UUID: lambda v: str(v)
        }

class Token(BaseModel):
    """Модель для JWT токена"""
    access_token: str
    token_type: str = "bearer"

class TokenData(BaseModel):
    """Модель данных в токене"""
    username: Optional[str] = None