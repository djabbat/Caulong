# Используем минимальный образ Python
FROM python:3.11.9-slim

# Устанавливаем утилиты для сборки и PostgreSQL-зависимости
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gcc \
        python3-dev \
        libpq-dev \
        netcat-openbsd && \
    rm -rf /var/lib/apt/lists/*

# Создаём непривилегированного пользователя
RUN adduser --disabled-password --gecos '' appuser && \
    mkdir -p /app && \
    chown -R appuser /app

# Рабочая директория
WORKDIR /app

# Копируем requirements и устанавливаем зависимости
COPY --chown=appuser:appuser requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем исходники приложения
COPY --chown=appuser:appuser . .

# Копируем скрипт ожидания БД и делаем его исполняемым
COPY --chown=appuser:appuser scripts/wait-for-db.sh /app/wait-for-db.sh
RUN chmod +x /app/wait-for-db.sh

# Переключаемся на непривилегированного пользователя
USER appuser

# Открываем порт
EXPOSE 8000

# Запускаем скрипт ожидания БД
ENTRYPOINT ["/app/wait-for-db.sh"]