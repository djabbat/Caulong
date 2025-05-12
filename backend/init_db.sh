#!/bin/bash

set -e # Прерывать при ошибках

echo "🟡 Ожидание CockroachDB..."
while ! nc -z cockroachdb 26257; do 
  sleep 1
done

echo "🟢 CockroachDB готов! Создаем базу данных и таблицы..."

# Создаем базу данных (если не существует)
cockroach sql --insecure --host=cockroachdb --execute="CREATE DATABASE IF NOT EXISTS caulong_db;"

# Создаем таблицу users
cockroach sql --insecure --host=cockroachdb --database=caulong_db --execute="
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username STRING NOT NULL UNIQUE,
    email STRING NOT NULL UNIQUE,
    password_hash STRING NOT NULL,
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now()
);
"

echo "🟢 База данных и таблицы успешно созданы!"