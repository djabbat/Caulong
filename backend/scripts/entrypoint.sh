#!/bin/bash
set -e

echo "🟡 Waiting for CockroachDB..."

# Ждем доступности CockroachDB с таймаутом
timeout 120s bash -c '
until cockroach sql --insecure --host=cockroachdb --execute="SHOW DATABASES;" &>/dev/null; do
  echo "⏳ CockroachDB not ready - sleeping..."
  sleep 2
done
'

echo "🟢 CockroachDB ready! Ensuring database exists..."

# Создаем базу данных (если не существует)
cockroach sql --insecure --host=cockroachdb --execute="CREATE DATABASE IF NOT EXISTS caulong_db;"

echo "🟢 Database ready! Applying migrations..."

# Применяем миграции с обработкой ошибок
cd /app && \
alembic upgrade head || {
    echo "❌ Migration failed, initializing database..."
    alembic stamp head
    alembic upgrade head
}

echo "🟢 Migrations applied! Starting server..."

exec uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload