#!/bin/sh
set -e

echo "🟡 Ожидание CockroachDB..."

# Ждём, пока CockroachDB станет доступен
until python3 -c "import socket; socket.create_connection(('cockroach', 26257), timeout=1)" >/dev/null 2>&1; do
  sleep 1
done

# Создаём БД
echo "🟢 Создание базы данных caulong_db..."
echo "CREATE DATABASE IF NOT EXISTS caulong_db;" | cockroach sql --insecure --host cockroach:26257