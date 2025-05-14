#!/bin/bash
set -e

echo "🟡 Waiting for CockroachDB to accept connections..."
until cockroach sql --insecure -e "SHOW DATABASES;" --host cockroachdb > /dev/null 2>&1; do
  echo "💤 Still waiting for CockroachDB..."
  sleep 2
done

echo "🟢 Creating database 'caulong_db' if not exists..."
cockroach sql --insecure -e "CREATE DATABASE IF NOT EXISTS caulong_db;" --host cockroachdb