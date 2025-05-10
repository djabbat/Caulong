#!/bin/sh
set -ex

# Ждём доступности CockroachDB
echo "🟡 Ожидание CockroachDB..."
while ! nc -z cockroach 26257; do
  sleep 1
done

# Дополнительная задержка для полной инициализации БД
sleep 5

echo "🟢 CockroachDB доступен!"

# Применяем миграции
echo "🟡 Применяем миграции..."
export PYTHONPATH=/app
python -m alembic upgrade head

# Запускаем сервер (exec заменяет текущий процесс)
echo "🟢 Запускаем FastAPI..."
exec python -m uvicorn backend.main:app --host 0.0.0.0 --port 8000