# Use official Python image (slim version)
FROM python:3.11-slim

# Set working directory inside the container
WORKDIR /analytics

# Install system dependencies
RUN apt-get update -y && \
    apt-get install -y build-essential libpq-dev && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip and build tools
RUN pip install --upgrade pip setuptools wheel

# Copy requirements file and install Python dependencies
COPY analytics/requirements.txt .
RUN pip install -r requirements.txt

# Copy the rest of the application code
COPY analytics/ .

# Set environment variables (optional defaults)
ENV DB_USERNAME=myuser
ENV DB_PASSWORD=mypassword
ENV DB_HOST=host.docker.internal
ENV DB_PORT=5433
ENV DB_NAME=mydatabase

# Expose port if your app runs on a web server (e.g., Flask default 5000)
EXPOSE 5000

# Default command to run your app
CMD ["python", "app.py"]

# Use official Python image (slim version)
FROM python:3.11-slim

# Set working directory inside the container
WORKDIR /analytics

# Install system dependencies
RUN apt-get update -y && \
    apt-get install -y build-essential libpq-dev && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip and build tools
RUN pip install --upgrade pip setuptools wheel

# Copy requirements file and install Python dependencies
COPY analytics/requirements.txt .
RUN pip install -r requirements.txt

# Copy the rest of the application code
COPY analytics/ .

# Set environment variables (optional defaults)
ENV DB_USERNAME=myuser
ENV DB_PASSWORD=mypassword
ENV DB_HOST=host.docker.internal
ENV DB_PORT=5433
ENV DB_NAME=mydatabase

# Expose port if your app runs on a web server (e.g., Flask default 5000)
EXPOSE 5000

# Default command to run your app
CMD ["python", "app.py"]

