# ABAC RLS PostgreSQL

Attribute-Based Access Control (ABAC) with Row-Level Security (RLS) implementation using PostgreSQL and Prisma.

## Prerequisites

- Node.js 18+ 
- Docker & Docker Compose
- npm or yarn

## Setup Instructions

### 1. Install Dependencies

```bash
npm install
```

### 2. Start PostgreSQL with Docker

Create a `docker-compose.yml` file in the project root (if not already present):

```yaml
version: '3.8'

services:
  postgres:
    image: postgres:16-alpine
    container_name: abac_rls_postgres
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: abac_rls_db
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 10s
      timeout: 5s
      retries: 5

volumes:
  postgres_data:
    driver: local
```

Start the PostgreSQL container:

```bash
docker-compose up -d
```

### 3. Configure Environment Variables

Copy the example environment file:

```bash
cp .env.example .env
```

Update `.env` with your database credentials (default Docker values):

```env
DATABASE_URL="postgres://postgres:postgres@localhost:5432/abac_rls_db?sslmode=disable"
```

### 4. Run Prisma Migrations

```bash
npx prisma migrate deploy
```

Or to create a new migration:

```bash
npx prisma migrate dev --name init
```

### 5. View Database with Prisma Studio

```bash
npx prisma studio
```

## Project Structure

```
.
├── prisma/
│   └── schema.prisma      # Prisma schema definition
├── lib/
│   └── prisma.ts          # Prisma client instance
├── generated/
│   └── prisma/            # Generated Prisma client
├── .env.example           # Environment variables template
├── docker-compose.yml     # Docker configuration
└── tsconfig.json          # TypeScript configuration
```

## Database Schema

### Tables

- **users** - User accounts with basic info
- **user_attributes** - Attribute-based user metadata
- **documents** - Resources with access control

### Features

- Row-Level Security (RLS) for fine-grained access control
- Attribute-Based Access Control (ABAC) for flexible policies
- Composite keys for efficient querying
- Cascade delete for data integrity

## Common Commands

### Start development

```bash
npm run dev
```

### Build

```bash
npm run build
```

### Clean up Docker

Stop the PostgreSQL container:

```bash
docker-compose down
```

Remove the database volume:

```bash
docker-compose down -v
```

## Troubleshooting

### Connection refused on port 5432

- Ensure Docker container is running: `docker-compose ps`
- Check DATABASE_URL in `.env`
- Verify PostgreSQL container health: `docker-compose logs postgres`

### Prisma migration conflicts

Reset the database (development only):

```bash
npx prisma migrate reset
```

## Resources

- [Prisma Documentation](https://www.prisma.io/docs/)
- [PostgreSQL RLS](https://www.postgresql.org/docs/current/ddl-rowsecurity.html)
- [Attribute-Based Access Control](https://en.wikipedia.org/wiki/Attribute-based_access_control)
