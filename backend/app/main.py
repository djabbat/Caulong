# app/main.py

from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import text
from app.database import get_db, engine, Base
from app.models import User
from app.schemas import UserCreate, UserResponse
from app.api.routes import router as auth_router
from passlib.context import CryptContext
import uuid
from datetime import datetime
import logging

# Password hashing context
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI()

# Include auth router
app.include_router(auth_router, prefix="/api/auth")

@app.on_event("startup")
def startup_event():
    try:
        logger.info("🟡 Initializing database...")
        Base.metadata.create_all(bind=engine)
        logger.info("🟢 Database initialized.")
    except Exception as e:
        logger.error(f"🔴 Failed to initialize database: {e}")
        raise

@app.post("/users/", response_model=UserResponse, status_code=201)
def create_user(user: UserCreate, db: Session = Depends(get_db)):
    try:
        existing_user = db.query(User).filter(
            (User.username == user.username) | (User.email == user.email)
        ).first()
        
        if existing_user:
            raise HTTPException(
                status_code=400,
                detail="Username or email already exists"
            )

        # Hash the password before storing
        hashed_password = pwd_context.hash(user.password)
        
        db_user = User(
            id=uuid.uuid4(),
            username=user.username,
            email=user.email,
            password=hashed_password,
            created_at=datetime.utcnow()
        )
        
        db.add(db_user)
        db.commit()
        db.refresh(db_user)
        logger.info(f"✅ User created: {db_user.username}")
        return db_user

    except HTTPException:
        raise
    except Exception as e:
        db.rollback()
        logger.error(f"🔴 Error creating user: {str(e)}", exc_info=True)
        raise HTTPException(
            status_code=500,
            detail="Internal server error"
        )

@app.get("/healthz")
def health_check(db: Session = Depends(get_db)):
    try:
        db.execute(text("SELECT 1"))
        return {"status": "ok"}
    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=f"Database error: {str(e)}"
        )

@app.get("/")
def read_root():
    return {"status": "Caulong API is running"}

@app.get("/users/", response_model=list[UserResponse])
def get_users(db: Session = Depends(get_db)):
    try:
        users = db.query(User).all()
        logger.info(f"Fetched {len(users)} users")
        return users
    except Exception as e:
        logger.error(f"🔴 Failed to fetch users: {str(e)}", exc_info=True)
        raise HTTPException(
            status_code=500,
            detail=f"Failed to fetch users: {str(e)}"
        )