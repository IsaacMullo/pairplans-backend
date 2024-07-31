# Use the official Python image from the Docker Hub
FROM python:3.11-slim

# Set environment variables to avoid any interaction with pip during the build process
ENV PYTHONUNBUFFERED 1

# Install necessary system dependencies
RUN apt-get update && \
    apt-get install -y build-essential default-libmysqlclient-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create and set working directory
WORKDIR /app

# Copy project requirements file
COPY requirements.txt /app/

# Install project dependencies
RUN python -m venv /opt/venv && \
    . /opt/venv/bin/activate && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

# Copy the project files
COPY . /app/

# Set the path to the virtual environment
ENV PATH="/opt/venv/bin:$PATH"

# Run migrations and collect static files
RUN python manage.py migrate && \
    python manage.py collectstatic --noinput

# Command to run the application
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "your_project_name.wsgi:application"]
