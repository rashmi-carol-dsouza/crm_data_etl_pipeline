# Dockerfile
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Install Poetry and copy dependency files
RUN pip install poetry
RUN pip install apache-airflow
COPY pyproject.toml poetry.lock ./

# Install dependencies via Poetry
RUN poetry install

# Copy the rest of the application code
COPY . .

# Expose port for Airflow (if needed)
EXPOSE 8080

# Default command (change if needed)
CMD ["poetry", "run", "airflow", "webserver"]
