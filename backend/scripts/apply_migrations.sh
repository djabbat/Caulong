#!/bin/bash
set -e

echo "🟡 Waiting for CockroachDB..."

while ! nc -z cockroach 26257; do
  sleep 1
done

echo "🟢 CockroachDB ready!"

cd /app/backend
exec python -m alembic upgrade head