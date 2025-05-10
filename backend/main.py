from fastapi import FastAPI, Depends, HTTPException
from pydantic import BaseModel
import asyncpg
from passlib.context import CryptContext

app = FastAPI()

# === ПАРОЛЬ ===
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password):
    return pwd_context.hash(password)

# === МОДЕЛИ ===
class UserCreate(BaseModel):
    email: str
    password: str
    full_name: str | None = None
    birth_date: str | None = None
    gender: str | None = None

# === БАЗА ДАННЫХ ===
DATABASE_URL = "postgresql+asyncpg://root@cockroach:26257/caulong_db?sslmode=disable"

@app.get("/health")
async def health_check():
    return {"status": "ok"}

@app.post("/register")
async def register(user: UserCreate):
    hashed_password = get_password_hash(user.password)
    try:
        pool = await asyncpg.create_pool(DATABASE_URL)
        async with pool.acquire() as conn:
            result = await conn.fetchrow(
                """
                INSERT INTO users (email, hashed_password, full_name, birth_date, gender)
                VALUES ($1, $2, $3, $4, $5)
                RETURNING id, email
                """,
                user.email,
                hashed_password,
                user.full_name,
                user.birth_date,
                user.gender
            )
            return {"id": result['id'], "email": result['email']}
    except asyncpg.UniqueViolationError:
        raise HTTPException(status_code=400, detail="Email уже существует")
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Ошибка сервера: {e}")