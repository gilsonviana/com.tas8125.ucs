# com.tas8125.ucs

A web application scaffold with a **ReactJS** frontend and a **plain PHP** backend backed by **MySQL**.

---

## Project Structure

```
.
├── docker-compose.yml          # Orchestrates all three services
├── .gitignore
├── frontend/                   # React 18 application
│   ├── public/
│   │   └── index.html
│   ├── src/
│   │   ├── index.js            # React entry point (createRoot)
│   │   ├── App.js              # Root component – fetches /items from the API
│   │   ├── App.css
│   │   ├── index.css
│   │   └── components/        # Place your reusable components here
│   ├── package.json
│   └── .env.example
├── backend/                    # Plain PHP 8.2 REST API
│   ├── public/
│   │   ├── index.php           # Entry point – CORS, autoloader, router
│   │   └── .htaccess           # Apache rewrite rules
│   └── src/
│       ├── Config/
│       │   └── Database.php    # PDO singleton
│       ├── Controllers/
│       │   └── ExampleController.php
│       └── Models/
│           └── ExampleModel.php
└── database/
    ├── schema.sql              # Table definitions
    └── seed.sql                # Sample rows
```

---

## Quick Start (Docker)

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) ≥ 24
- [Docker Compose](https://docs.docker.com/compose/install/) v2

### 1. Clone and configure

```bash
# Copy environment files
cp frontend/.env.example frontend/.env
cp backend/.env.example  backend/.env
```

### 2. Start all services

```bash
docker compose up --build
```

| Service  | URL                    |
|----------|------------------------|
| Frontend | http://localhost:3000  |
| Backend  | http://localhost:8080  |
| MySQL    | localhost:3306         |

### 3. Stop services

```bash
docker compose down          # keep data volume
docker compose down -v       # also remove MySQL data
```

---

## Running Without Docker

### Frontend

```bash
cd frontend
npm install
cp .env.example .env         # edit REACT_APP_API_URL if needed
npm start                    # http://localhost:3000
```

### Backend

Serve `backend/public/` with any Apache virtual-host that has `mod_rewrite` enabled, or use the PHP built-in server (routing must be handled manually):

```bash
cd backend/public
php -S localhost:8080 index.php
```

Set the environment variables before starting:

```bash
export DB_HOST=127.0.0.1
export DB_NAME=appdb
export DB_USER=appuser
export DB_PASSWORD=apppassword
```

### Database

```bash
mysql -u root -p appdb < database/schema.sql
mysql -u root -p appdb < database/seed.sql
```

---

## API Endpoints

Base URL: `http://localhost:8080`

| Method | Path         | Description          |
|--------|--------------|----------------------|
| GET    | /items       | List all items       |
| GET    | /items/{id}  | Get a single item    |
| POST   | /items       | Create a new item    |
| PUT    | /items/{id}  | Update an item       |
| DELETE | /items/{id}  | Delete an item       |

### Example request

```bash
# Create an item
curl -X POST http://localhost:8080/items \
  -H "Content-Type: application/json" \
  -d '{"name":"New item","description":"A sample item"}'

# List all items
curl http://localhost:8080/items
```

---

## Development Notes

- **Adding a new resource** – duplicate `ExampleController.php` and `ExampleModel.php`, then register the new routes in `backend/public/index.php`.
- **Frontend environment** – all `REACT_APP_*` variables in `frontend/.env` are injected at build time by Create React App.
- **CORS** – the wildcard `Access-Control-Allow-Origin: *` in `index.php` is fine for local development; restrict it to specific origins before deploying to production.
