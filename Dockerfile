FROM python:3.10-slim

# Install system deps
RUN apt update && apt install -y \
    git curl unzip openjdk-17-jdk \
    && rm -rf /var/lib/apt/lists/*

# Create app dir
WORKDIR /app

# Clone Crafty
RUN git clone https://gitlab.com/crafty-controller/crafty-4.git .

# Install Python deps
RUN pip install --no-cache-dir -r requirements.txt

# Expose port
EXPOSE 8000

# Start Crafty
CMD ["python3", "main.py"]
