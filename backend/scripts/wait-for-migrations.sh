#!/bin/bash
set -e

echo "🟡 Ожидание готовности CockroachDB..."

# Ждём, пока healthcheck CockroachDB не станет healthy
while ! cockroach sql --insecure --host=cockroachdb --execute="SHOW DATABASES;" &>/dev/null; do
  echo "⏳ CockroachDB ещё не готов, ждём..."
  sleep 2
done

echo "🟢 CockroachDB готов, применяем миграции..."

cd /app

# Применяем миграции
alembic upgrade head

echo "🟢 Миграции успешно применены!"