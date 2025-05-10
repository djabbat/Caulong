FROM python:3.11-slim-bookworm

# Установка зависимостей
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    python3-dev \
    libpq-dev \
    netcat-openbsd && \
    rm -rf /var/lib/apt/lists/*

# Создаем пользователя
RUN useradd -m appuser && \
    mkdir -p /app && \
    chown -R appuser:appuser /app

WORKDIR /app
USER appuser

# Копируем requirements.txt первым для кэширования
COPY --chown=appuser:appuser ./backend/requirements.txt .

# Устанавливаем зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Копируем остальной код
COPY --chown=appuser:appuser ./backend/ /app/

# Делаем скрипт исполняемым
RUN chmod +x /app/wait-for-db.sh

EXPOSE 8000

# Используем скрипт как точку входа
CMD ["/app/wait-for-db.sh"]