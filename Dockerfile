# Stage 1: Setup Base Image
FROM node:20-alpine AS base
ARG NODE_ENV production
ENV NODE_ENV $NODE_ENV
WORKDIR /app
RUN corepack enable && \
    corepack prepare pnpm@latest-8 --activate

# Stage 2: Install Dependencies
FROM base AS install
RUN pnpm config set store-dir .pnpm-store
COPY package.json pnpm-lock.yaml .npmrc ./
RUN pnpm install --frozen-lockfile --ignore-scripts

# Stage 3: Build Application
FROM base AS builder
COPY --from=install /app/node_modules ./node_modules
COPY . .
RUN pnpm run build:production

# Stage 4: Release Image Application
FROM oven/bun:1-alpine
WORKDIR /app
RUN apk --no-cache add dumb-init=~1.2.5
# Ensure the container runs as a non-root user
USER bun
COPY --chown=bun:bun --from=builder /app/.output .
# Expose the port your app runs on
EXPOSE 3000/tcp
# Get Host from environment variable
# This is used to allow the container to be run on any host
ENV HOST 0.0.0.0
ENV NUXT_HOST=0.0.0.0
# Adjusted command to directly run the server in production
# Following Nuxt's recommendation for production deployments
# Use ENTRYPOINT to ensure the environment variable is evaluated
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["sh", "-c", "bun run server/index.mjs --host $NUXT_HOST"]
