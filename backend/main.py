from fastapi import FastAPI
import os
from alembic.config import Config
from alembic import command

app = FastAPI()

@app.get("/")
def read_root():
    return {"Hello": "World"}

def run_migrations():
    alembic_cfg = Config("alembic.ini")
    command.upgrade(alembic_cfg, "head")

if os.getenv("RUN_MIGRATIONS", "false").lower() == "true":
    run_migrations()
