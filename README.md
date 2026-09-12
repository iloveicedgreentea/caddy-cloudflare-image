# Caddy with the Cloudflare DNS module

This is a small, reproducible extension of the official [`caddy:2.11.4-alpine`](https://hub.docker.com/_/caddy) image. It adds only `github.com/caddy-dns/cloudflare`, which lets Caddy complete ACME DNS-01 challenges through Cloudflare.

## Use

```yaml
image: ghcr.io/OWNER/caddy-cloudflare:2.11.4-cloudflare
```

Replace `OWNER` with this repository's GitHub owner. For a reproducible deployment, pin the image digest published on the [package page](../../pkgs/container/caddy-cloudflare).

A minimal Caddyfile using a Cloudflare API token supplied at runtime:

```caddyfile
app.example.com {
    tls {
        dns cloudflare {env.CLOUDFLARE_API_TOKEN}
    }
    reverse_proxy backend:8080
}
```

## Security

- No credentials are included in this repository or image.
- Supply `CLOUDFLARE_API_TOKEN` through your host's secret manager or environment configuration; never add it to a Caddyfile, image, Git repository, or Docker label.
- Grant the token only the Cloudflare DNS edit permission for the required zone(s).
- The Cloudflare module is built from the pinned commit in the Dockerfile. Caddy itself is pinned to `2.11.4`.
- Tags are convenient; production deployments should pin a published digest.

## Published tags

The GitHub Actions workflow publishes multi-architecture images for `linux/amd64` and `linux/arm64`:

- `2.11.4-cloudflare`
- the full commit SHA
- `latest` (only from the default branch)

The base image follows the official Caddy image's defaults, including its entrypoint and standard ports.
