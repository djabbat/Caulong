#!/bin/bash
set -e

echo "🟡 Waiting for CockroachDB to become available..."

# Ждём, пока CockroachDB начнёт принимать подключения на порту 26257
until nc -z cockroachdb 26257; do
  echo "💤 Still waiting for CockroachDB..."
  sleep 2
done

echo "🟢 CockroachDB is ready!"

# Запускаем FastAPI приложение
exec uvicorn app.main:app --host 0.0.0.0 --port 8000