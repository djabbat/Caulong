CREATE DATABASE caulong_db;

\c caulong_db

CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    username TEXT UNIQUE NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO users (username, email, password) VALUES
('Dr Jaba Tkemaladze', 'djabbat@gmail.com', '$2b$12$7T4Pn9BQYwzZxJzL7UWIjOeGyVhXaI7.Yu8mWlDpFqSv6dKtNnK2.');