#!/bin/bash
set -e

max_retries=30
counter=0

echo "🟡 Waiting for CockroachDB..."
until cockroach sql --insecure --host=cockroachdb --execute="SELECT 1" > /dev/null 2>&1; do
  sleep 1
  ((counter++))
  if [ $counter -ge $max_retries ]; then
    echo "🔴 CockroachDB not available after $max_retries attempts"
    exit 1
  fi
done

echo "🟢 CockroachDB ready! Applying migrations..."
cd /app && python -m alembic upgrade head