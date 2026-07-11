# 1. Pull the absolute latest production-grade NVIDIA CUDA runtime image
FROM nvidia/cuda:12.6.3-runtime-ubuntu24.04

# Core Fix: Force Node.js and the Linux kernel to run at raw maximum scheduling speeds
ENV DEBIAN_FRONTEND=noninteractive \
    NODE_ENV=production \
    UV_THREADPOOL_SIZE=128 \
    NODE_OPTIONS="--max-http-header-size=16384 --expose-gc"

# 2. Install native system drivers required for WebRTC hardware media codecs
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    gnupg \
    build-essential \
    libv4l-dev \
    libvpx-dev \
    libx264-dev \
    libopus-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 3. Securely provision the modern Node.js 22 LTS runtime engine using official distribution setups
RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://nodesource.com | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://nodesource.com nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 4. Handle isolated dependency assembly with aggressive cache clearing
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

# 5. Pull your application files and your custom fragment shader
COPY . .

# 6. Security Layer: Enforce a secure, non-root system user profile
RUN useradd -m sparkuser && chown -R sparkuser:sparkuser /app
USER sparkuser

# Expose the standard secure WebSocket signaling port utilized by GCP Cloud Run
EXPOSE 8080

# Ignite your Infinite FPS vector tracking and haptic data signaling hub
CMD ["node", "server.js"]
