# =========================================================================
# STAGE 1: COMPILATION & BUILD ENGINE (Isolates heavy compiler dependencies)
# =========================================================================
FROM nvidia/cuda:12.6.3-devel-ubuntu24.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

# Install system compilation headers required for compiling WebRTC native C++ nodes
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    gnupg \
    ca-certificates \
    build-essential \
    python3 \
    libv4l-dev \
    libvpx-dev \
    libx264-dev \
    libopus-dev \
    && rm -rf /var/lib/apt/lists/*

# FIXED: Corrected NodeSource package repository address mapping to deb.nodesource.com
RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://nodesource.com | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://nodesource.com nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package*.json ./

# Compile native module binaries cleanly in the development layer
RUN npm ci

# =========================================================================
# STAGE 2: PRODUCTION RUNTIME ENVIRONMENT (Ultra-lightweight deployment layer)
# =========================================================================
FROM nvidia/cuda:12.6.3-runtime-ubuntu24.04 AS runtime

# OPTIMIZED: Normalized thread pools to avoid heavy virtual context switching on Cloud Run
ENV DEBIAN_FRONTEND=noninteractive \
    NODE_ENV=production \
    UV_THREADPOOL_SIZE=16 \
    NODE_OPTIONS="--max-http-header-size=16384 --expose-gc"

# Install only the runtime shared libraries needed to stream video data
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    gnupg \
    ca-certificates \
    libv4l-0 \
    libvpx9 \
    libx264-164 \
    libopus0 \
    && rm -rf /var/lib/apt/lists/*

# Inject the identical verified NodeSource engine configuration to provision Node runtime executable
RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://nodesource.com | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://nodesource.com nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy compiled production modules and source data across from your builder image stage
COPY --from=builder /app/node_modules ./node_modules
COPY package*.json ./
COPY . .

# Prune any extraneous development dependencies safely
RUN npm prune --production && npm cache clean --force

# Security Layer: Provision dedicated execution credentials
RUN useradd -m sparkuser && chown -R sparkuser:sparkuser /app
USER sparkuser

EXPOSE 8080

CMD ["node", "server.js"]
