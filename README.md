# SimpleTimeService (Python)

A minimal Python microservice that returns current timestamp and visitor IP in JSON format.

## Features
- Returns JSON with UTC timestamp and client IP
- Runs as non-root user in container
- Health check endpoint at `/health`
- Uses Gunicorn as production WSGI server
- Proper IP handling considering proxy headers

## Prerequisites
- Docker installed

## Building the Container
```bash
docker build -t simple-time-service .

Running the Container
docker run -d -p 3000:3000 --name time-service simple-time-service

Testing the Service
curl http://localhost:3000

Example Output
{
  "ip": "172.17.0.1",
  "timestamp": "2025-07-11T10:50:27.260562Z"
}

Health Check
curl http://localhost:3000/health

Pulling from Docker Hub
docker pull <yourusername>/simple-time-service:latest

Python 3.11 with Flask
Multi-stage Docker build for minimal image size (~120MB)
Non-root user for security
Health checks for container monitoring
Gunicorn as production server
Proper IP handling considering X-Forwarded-For headers
