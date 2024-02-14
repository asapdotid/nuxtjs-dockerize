# Nuxt 3 Minimal Starter Testing

Initial setup NuxtJs for docker image.

Docker image can find on Docker Hub: `asapdotid/nuxtjs-test:latest` multi platform `linux/amd64` & `linux/arm64`

- linux/amd64 ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/asapdotid/nuxtjs-test/latest?arch=amd64&style=flat-square&logo=docker)
- linux/arm64 ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/asapdotid/nuxtjs-test/latest?arch=arm64&style=flat-square&logo=docker)

Test running

```bash
docker run -it -p 3000:3000 asapdotid/nuxtjs-test:latest
```

## Setup Docker Image

Config Docker Image Build:

- [x] Manual build
- [x] Github Workflows
- [ ] Google Cloud Build

Config Application

- [ ] Update Application

### Manual setup using `Makefile`:

Initial make:

```bash
make init
```

Build Application image:

```bash
make build
# or
make build-push
```

- Initial Docker base image
- Install dependencies
- Build Application
- Release Application (Docker image)

## Setup running NuxtJs

Make sure to install the dependencies:

```bash
# npm
npm install

# pnpm
pnpm install

# yarn
yarn install

# bun
bun install
```

## Development Server

Start the development server on `http://localhost:3000`:

```bash
# npm
npm run dev

# pnpm
pnpm run dev

# yarn
yarn dev

# bun
bun run dev
```

## Production

Build the application for production:

```bash
# npm
npm run build

# pnpm
pnpm run build

# yarn
yarn build

# bun
bun run build
```

Locally preview production build:

```bash
# npm
npm run preview

# pnpm
pnpm run preview

# yarn
yarn preview

# bun
bun run preview
```

Check out the [deployment documentation](https://nuxt.com/docs/getting-started/deployment) for more information.
