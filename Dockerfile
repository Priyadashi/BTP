# Use the Debian-based “buster” slim image which has better support
FROM python:3.9-slim-buster

WORKDIR /app

# Install build tools for compiling scikit-learn and numpy
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential \
      gcc \
      libgomp1 \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python deps
COPY requirements.txt ./
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy your app code and model
COPY app.py model.pkl ./

EXPOSE 5000
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]
