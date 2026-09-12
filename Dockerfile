# syntax=docker/dockerfile:1
# This only adds Caddy's Cloudflare DNS module to the official Caddy release.
FROM caddy:2.11.4-builder-alpine AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare=github.com/EgorYolkin/cloudflare@6c8087eb18b6c55d23c135369afc4a134314e4f2

FROM caddy:2.11.4-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
