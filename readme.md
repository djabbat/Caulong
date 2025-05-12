# Caucasian Longevity

Caulong App

## Getting Started

# Из корневой директории проекта
---
- docker-compose up -d --build
---

## Build

### Android
flutter build apk --release

### iOS
flutter build ios --release

### Web
flutter build web --release

### Windows
flutter build windows --release

### macOS
flutter build macos --release

### Linux
flutter build linux --release
# Caulong — мобильное приложение для здоровья через дыхание, сон и питание

![Логотип Caulong](logo.png)

## О проекте

**caulong** — это инновационное мобильное приложение, помогающее пользователям улучшать здоровье посредством анализа состояния организма и персонализированных рекомендаций по дыханию, сну и питанию.

Приложение использует данные о пользователе (дата рождения, пол), клинические анализы, текстовые записи, звуковые файлы и медицинские снимки для анализа состояния здоровья и генерации рекомендаций с помощью искусственного интеллекта.

---

## Технологии

- **Flutter** — фреймворк для разработки кроссплатформенных приложений
- **CockroachDB** — база данных для миллиардов пользователей
- **Redis / Memcached** — кэширование данных
- **PyTorch + FastAPI** — модель ИИ и серверная часть
- **JWT** — безопасность авторизации
- **GCP** — облачная инфраструктура
---

## Структура папок и файлов

```


---

## Архитектура: BLoC

Для реализации бизнес-логики используется **BLoC (Business Logic Component)**:
- Разделение UI и логики
- Удобство тестирования
- Простая масштабируемость

Пример:
```dart
class HealthBloc extends Bloc<HealthEvent, HealthState> {
  final HealthRepository _repository;

  HealthBloc(this._repository) : super(InitialHealthState());

  @override
  Stream<HealthState> mapEventToState(HealthEvent event) async* {
    if (event is AnalyzeHealthEvent) {
      yield LoadingHealthState();
      try {
        final result = await _repository.analyze(event.userData);
        yield SuccessHealthState(result);
      } catch (_) {
        yield ErrorHealthState();
      }
    }
  }
}
```

---

## База данных: CockroachDB

Flutter App (caulong)
       ↓
HTTP API (FastAPI)
       ↓
PostgreSQL protocol
       ↓
CockroachDB (распределённая SQL БД)

### Установка CockroachDB (Linux/macOS)

url https://binaries.cockroachdb.com/cockroach-v23.2.6.linux-amd64.tgz  | tar -xz
sudo cp cockroach-v23.2.6.linux-amd64/cockroach /usr/local/bin/c

### Запуск локального узла

Убедитесь, что установлены:
- Docker
- Docker Compose
- Flutter SDK
- Alembic

Перейдите в папку с проектом и выполните:

Сборка: 
- docker-compose build

Запуск миграций: 
- docker-compose run --rm fastapi python -m alembic upgrade head

Запуск API сервера:
- docker-compose up fastapi
Он будет доступен по адресу:
👉 http://localhost:8000

Запуск всех сервисов: 
- docker-compose up -d

Остановка сервисов вручную: 
- docker-compose down

## Как локально запустить ИИ

### Установите зависимости

В папке с FastAPI сервером:
- pip install fastapi uvicorn torch torchvision torchaudio pydantic

### Запуск FastAPI

- uvicorn main:app --reload

### Общее описание

Для работы с миллиардами пользователей используется **CockroachDB** — горизонтально масштабируемая распределённая база данных. Она сочетает мощь SQL с возможностью глобального масштабирования и высокой доступности.

### Особенности:
- Поддержка ACID-транзакций
- Распределённые транзакции
- Горизонтальное масштабирование
- Репликация между регионами
- Интеграция с GCP

### Шардинг

Cloud Spanner автоматически шардирует данные по всему кластеру. Однако можно задать ключи разделения для оптимизации производительности:

```sql
CREATE TABLE Users (
  UserId INT64 NOT NULL,
  Name STRING(MAX),
  Gender STRING(10),
  BirthDate DATE,
  LastLogin TIMESTAMP OPTIONS (allow_commit_timestamp=true),
) PRIMARY KEY (UserId)
INTERLEAVE IN PARENT Regions ON DELETE CASCADE;
```

### Кеширование

Для повышения скорости используются:
- **Redis** (в GCP: Memorystore for Redis)
- **Memcached** (альтернатива Redis)

Пример использования Redis:
```python
import redis

r = redis.Redis(host='redis-instance', port=6379, db=0)

def get_cached_health(user_id):
    return r.get(f"health:{user_id}")

def set_cached_health(user_id, data):
    r.setex(f"health:{user_id}", 86400, data)  # хранить 24 часа
```
## Искусственный интеллект (ИИ)

### Что делает ИИ?

- Анализ состояния здоровья по данным:
  - Пол
  - Дата рождения
  - Клинические анализы
  - Текстовые заметки
  - Аудиозаписи (например, кашель, дыхание)
  - Медицинские снимки (X-ray, МРТ)

### Выход ИИ:
- Рекомендации по дыханию
- Советы по сну
- Персонализированное питание

---

## Подключение к ИИ

### Шаг 1: Создайте модель на PyTorch

Модель может быть сверточной нейросетью для анализа изображений, LSTM для текста и RNN для звука.

```python
import torch
from torch import nn

class HealthModel(nn.Module):
    def __init__(self):
        super().__init__()
        self.cnn = nn.Conv2d(...)
        self.rnn = nn.LSTM(...)

    def forward(self, x):
        ...
```

### Шаг 2: API-сервер на FastAPI

```python
from fastapi import FastAPI, Depends, HTTPException
from pydantic import BaseModel
import ai_model

app = FastAPI()

class UserInput(BaseModel):
    birth_date: str
    gender: str
    text_notes: str
    image_url: str
    audio_url: str

@app.post("/analyze")
async def analyze_health(data: UserInput, token: str = Depends(validate_jwt)):
    result = ai_model.predict(data)
    return {"recommendations": result}
```
### Шаг 4: Безопасность

- **JWT-токены**: проверка прав пользователя
- **Rate Limiting**: ограничение на количество запросов
- **HTTPS**: обязательное использование

### Шаг 5: Подключение из Flutter

```dart
Future<void> sendToAI(UserData data) async {
  final url = Uri.parse('https://ai-api.example.com/analyze');
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(data.toJson()),
  );
  
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    print("AI recommendations: $result");
  } else {
    throw Exception('Ошибка при анализе данных');
  }
}
```

---

## Команды сборки

```bash
# Очистка
flutter clean

# Получение зависимостей
flutter pub get

# Запуск
flutter run

# Сборка под платформы
flutter build apk --release
flutter build ios --release
flutter build web --release # 👉 http://localhost:81
flutter build windows --release
flutter build macos --release
flutter build linux --release
```