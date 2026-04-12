services:
  db:
    image: postgres:14
    container_name: hm_jenkins_postgres_db
    restart: unless-stopped
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: pass
      POSTGRES_DB: mydb
    volumes:
      - jenkins_postgres_data:/var/lib/postgresql/data
    ports:
      - "55433:5432"

  backend:
    image: python:3.11-slim
    container_name: hm_jenkins_fastapi_app
    working_dir: /app
    volumes:
      - ./backend:/app
    command: >
      sh -c "pip install --no-cache-dir -r requirements.txt &&
             uvicorn app.main:app --host 0.0.0.0 --port 8000"
    environment:
      DATABASE_URL: postgresql://user:pass@db:5432/mydb
    depends_on:
      - db
    ports:
      - "8202:8000"

  frontend:
    image: node:20-alpine
    container_name: hm_jenkins_react_app
    working_dir: /app
    volumes:
      - ./frontend:/app
      - /app/node_modules
    command: >
      sh -c "npm install &&
             npm run dev -- --host 0.0.0.0 --port 3000"
    environment:
      VITE_API_URL: http://16.16.170.141:8202
    depends_on:
      - backend
    ports:
      - "3200:3000"

volumes:
  jenkins_postgres_data:
