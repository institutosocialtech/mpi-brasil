# syntax=docker/dockerfile:1.7

# ---------------------------------------------------------------------------
# Stage 1: build the Flutter web app (WebAssembly target)
# ---------------------------------------------------------------------------
ARG FLUTTER_VERSION=3.41.9

FROM debian:bookworm-slim AS builder
ARG FLUTTER_VERSION

ENV DEBIAN_FRONTEND=noninteractive \
    FLUTTER_HOME=/opt/flutter \
    PUB_CACHE=/root/.pub-cache \
    PATH=/opt/flutter/bin:/root/.pub-cache/bin:$PATH

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      ca-certificates curl git unzip xz-utils zip \
 && rm -rf /var/lib/apt/lists/*

# Flutter SDK straight from GitHub, pinned to a release tag.
RUN git clone --depth 1 --branch "${FLUTTER_VERSION}" \
      https://github.com/flutter/flutter.git "${FLUTTER_HOME}" \
 && git config --global --add safe.directory "${FLUTTER_HOME}" \
 && flutter config --no-analytics --enable-web \
 && flutter precache --web \
 && flutter --version

WORKDIR /app

# Resolve dependencies first so this layer is cached while sources change.
COPY pubspec.yaml pubspec.lock ./
RUN --mount=type=cache,target=/root/.pub-cache \
    flutter pub get

COPY . .

RUN --mount=type=cache,target=/root/.pub-cache \
    flutter pub get \
 && dart run intl_utils:generate \
 && flutter build web --release --wasm

# ---------------------------------------------------------------------------
# Stage 2: serve the static bundle with Caddy
# ---------------------------------------------------------------------------
FROM caddy:2-alpine AS runtime

COPY docker/Caddyfile /etc/caddy/Caddyfile
COPY --from=builder /app/build/web /srv

EXPOSE 80
