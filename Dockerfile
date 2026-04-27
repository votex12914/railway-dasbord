FROM python:3.10-bullseye

# Install system dependencies (fixed Java issue)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    openjdk-17-jdk \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set Java env (important for Minecraft)
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Set working directory
WORKDIR /app

# Clone Crafty Controller
RUN git clone https://gitlab.com/crafty-controller/crafty-4.git .

# Install Python requirements
RUN pip install --no-cache-dir -r requirements.txt

# Create required folders (prevents crash)
RUN mkdir -p /app/app/config /app/app/servers /app/app/backups

# Expose Crafty panel port
EXPOSE 8000

# Start Crafty
CMD ["python3", "main.py"]
