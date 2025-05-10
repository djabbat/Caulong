from logging.config import fileConfig
from alembic import context
from sqlalchemy.ext.asyncio import create_async_engine
import asyncio
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(__file__)))

from models import Base

config = context.config
fileConfig(config.config_file_name)

def run_migrations_offline():
    url = config.get_main_option("sqlalchemy.url")
    context.configure(
        url=url,
        target_metadata=Base.metadata,
        literal_binds=True,
        dialect_opts={"paramstyle": "named"},
    )

    with context.begin_transaction():
        context.run_migrations()

async def run_migrations_online():
    connectable = create_async_engine(
        os.getenv("DATABASE_URL", config.get_main_option("sqlalchemy.url")),
        connect_args={"server_settings": {"application_name": "alembic"}}
    )

    async with connectable.connect() as connection:
        await connection.run_sync(
            lambda sync_conn: context.configure(
                connection=sync_conn,
                target_metadata=Base.metadata,
                compare_type=True,
            )
        )

        async with connection.begin():
            await connection.run_sync(context.run_migrations)

if context.is_offline_mode():
    run_migrations_offline()
else:
    asyncio.run(run_migrations_online())