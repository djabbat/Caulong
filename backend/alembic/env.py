from logging.config import fileConfig
from sqlalchemy import engine_from_config, pool
from alembic import context
import sys
import os

# Добавляем путь к проекту
sys.path.append(os.path.dirname(os.path.dirname(__file__)))

# Импортируем модели
from backend.models import Base
from backend.database import engine  # Явный импорт engine

# Конфигурация Alembic
config = context.config
fileConfig(config.config_file_name)
target_metadata = Base.metadata

def run_migrations_online():
    connectable = engine

    with connectable.connect() as connection:
        context.configure(
            connection=connection,
            target_metadata=target_metadata,
            compare_type=True,
            render_as_batch=True  # Важно для CockroachDB
        )

        with context.begin_transaction():
            context.run_migrations()

run_migrations_online()