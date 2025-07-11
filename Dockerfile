# Stage 1: Build
FROM python:3.11-slim as builder

WORKDIR /app
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# Stage 2: Runtime
FROM python:3.11-slim

WORKDIR /app
COPY --from=builder /root/.local /root/.local
COPY app ./app

# Install gunicorn system-wide in final stage
RUN pip install --no-cache-dir gunicorn && \
    useradd -m appuser && \
    chown -R appuser /app

# In the final stage, add this before USER appuser:
RUN mkdir -p /home/appuser/.local && \
    cp -r /root/.local /home/appuser/ && \
    chown -R appuser:appuser /home/appuser/.local
ENV PATH=/home/appuser/.local/bin:$PATH

USER appuser

# Ensure PATH includes both system and user Python paths
ENV PATH=/root/.local/bin:/usr/local/bin:$PATH

EXPOSE 3000
CMD ["gunicorn", "--bind", "0.0.0.0:3000", "app.main:app"]