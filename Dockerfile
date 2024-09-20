# Builder stage
FROM python:3.11-buster as builder

ENV PYTHONFAULTHANDLER=1 \
    PYTHONHASHSEED=random \
    PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y gcc libffi-dev g++

WORKDIR /app

RUN pip install poetry==1.8.2

ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1 \
    POETRY_CACHE_DIR=/tmp/poetry_cache

COPY pyproject.toml poetry.lock ./
RUN poetry install --no-root && rm -rf $POETRY_CACHE_DIR

# Runtime stage
FROM python:3.11-slim-buster as runtime

ENV PYTHONFAULTHANDLER=1 \
    PYTHONHASHSEED=random \
    PYTHONUNBUFFERED=1 \
    VIRTUAL_ENV=/app/.venv \
    PATH="/app/.venv/bin:$PATH"

WORKDIR /app

# Copy the virtual environment from the builder stage
COPY --from=builder /app/.venv /app/.venv

# Copy Poetry configuration files
COPY --from=builder /app/pyproject.toml /app/poetry.lock ./

# Install Poetry in the runtime stage
RUN pip install poetry==1.8.2

# Copy the rest of your application
COPY . .

RUN chmod +x /app/django.sh

EXPOSE 8000

ENTRYPOINT ["/app/django.sh"]