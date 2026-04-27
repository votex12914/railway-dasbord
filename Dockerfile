FROM python:3.10-bullseye

# Install dependencies (Java fixed)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    openjdk-17-jdk \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set Java environment
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Set working directory
WORKDIR /app

# Clone Crafty
RUN git clone https://gitlab.com/crafty-controller/crafty-4.git .

# Install Python deps
RUN pip install --no-cache-dir -r requirements.txt

# Fix permissions (important)
RUN mkdir -p /app/app/config /app/app/servers /app/app/backups
RUN chmod -R 777 /app

# Expose port
EXPOSE 8000

# FIXED START (this solves stuck issue)
CMD ["sh", "-c", "python3 main.py --host 0.0.0.0 --port ${PORT:-8000}"]
