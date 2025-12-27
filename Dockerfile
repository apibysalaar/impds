FROM node:18-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy package files and install Node.js dependencies
COPY package*.json ./
RUN npm install --production

# Install Python packages with --break-system-packages flag
COPY requirements.txt .
RUN pip3 install --no-cache-dir --break-system-packages -r requirements.txt

# Copy application code
COPY . .

EXPOSE 3000
CMD ["node", "server.js"]
