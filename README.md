# Django Rest framework CURD with postgres and docker

Simple CURD  operation with DRF

## Installation

1. Install poetry

```bash
curl -sSL https://install.python-poetry.org | python3 -
```

2. Clone repo and install depedencies

```bash  
git clone https://github.com/karuna-sth/drf-curd-postgres-docker.git
cd drf-curd-postgres-docker
poetry install
```

## Usage

1.  Make Migrations

```bash
poetry run python manage.py makemigrations
poetry run python manage.py migrate
```

2. Start Server

```bash
poetry run python manage.py runserver 0.0.0.0:8000
```

3. Navigate to `localhost:8000/swagger`

## Installation with Docker

```bash
docker-compose up --build
```

## API ENDPOINTS

- `GET /users`: Retrieve a list of all users.
- `POST /users`: Create new users.
- `GET /users/<int:id>`: Retrieve a users by id.
- `PUT /users/<int:id>`: Update users info by id.
- `DELETE /users/<int:id>`: Delete users by id.