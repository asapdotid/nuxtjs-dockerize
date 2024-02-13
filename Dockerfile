# Stage 1: install dependencies
FROM node:20-alpine AS base
ARG NODE_ENV production
ENV NODE_ENV $NODE_ENV
WORKDIR /app
RUN corepack enable && \
    corepack prepare pnpm@latest-8 --activate

FROM base AS install
RUN pnpm config set store-dir .pnpm-store
COPY package.json pnpm-lock.yaml .npmrc ./
RUN pnpm install --frozen-lockfile --ignore-scripts

# Stage 2: build
FROM base AS builder
COPY --from=install /app/node_modules ./node_modules
COPY . .
RUN pnpm run build:production

# Stage 3: run
FROM oven/bun:1-alpine
WORKDIR /app
COPY --chown=bun:bun --from=builder /app/.output .
# Ensure the container runs as a non-root user
USER bun
# Expose the port your app runs on
EXPOSE 3000/tcp
# Get Host from environment variable
# This is used to allow the container to be run on any host
ENV NUXT_HOST=0.0.0.0
ENV HOST 0.0.0.0
# Adjusted command to directly run the server in production
# Following Nuxt's recommendation for production deployments
# Use ENTRYPOINT to ensure the environment variable is evaluated
ENTRYPOINT ["sh", "-c", "bun run server/index.mjs --host $NUXT_HOST"]
