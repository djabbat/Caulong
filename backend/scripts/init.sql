CREATE DATABASE IF NOT EXISTS caulong_db;
\c caulong_db
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username STRING NOT NULL UNIQUE,
    email STRING NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT now()
);