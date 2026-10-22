# Base

Polydice's base docker image for Rails applications.

## Variants

- `x.y.z` - Standard image for running on production
- `x.y.z-testing` - Image for testing which includes additional packages:
  - git
  - openssh-client
  - libxml2-dev
  - libxslt1-dev
  - libsasl2-dev
  - libmcrypt-dev

## Architectures

- `linux/amd64` (x86_64)
- `linux/arm64` (Graviton, Apple Silicon)

## Versions

| Version | Ruby   | Node.js | Yarn    | Bundler | pnpm  | ARM64 |
|---------|--------|---------|---------|---------|-------|-------|
| 0.34.0  | 3.4.11 | 18.18.0 | 1.22.22 | 2.6.9   | 9.9.0 | ✅    |
| 0.33.0  | 3.3.12 | 18.18.0 | 1.22.22 | 2.5.22  | 9.9.0 | ✅    |
| 0.32.0  | 2.7.8  | 18.18.0 | 1.22.22 | 2.4.22  | 9.9.0 | ✅    |
| 0.31.2  | 2.7.8  | 18.18.0 | 1.22.22 | 2.4.20  | 9.9.0 | ❌    |
| 0.31.1  | 2.7.8  | 18.18.0 | 1.22.19 | 2.4.20  | 8.8.0 | ❌    |
| 0.31.0  | 2.7.7  | 18.18.0 | 1.22.19 | 2.4.5   | 8.8.0 | ❌    |
| 0.30.3  | 2.7.7  | 14.21.2 | 1.22.19 | 2.4.5   |       | ❌    |

## Release

1. Update version in README.md
2. Commit and push tag:
   ```bash
   git tag <version>
   git push origin <version>
   ```
3. GitHub Actions will automatically:
   - Build multi-arch images (amd64 + arm64)
   - Push to DockerHub
   - Sync to ECR Public

## Changes in 0.34.0

- Upgraded Ruby from 3.3.12 to 3.4.11
- Upgraded Bundler from 2.5.22 to 2.6.9 (ships with Ruby 3.4.11)

## Changes in 0.33.0

- Upgraded Ruby from 2.7.8 to 3.3.12 (base image now Debian 13 trixie)
- Upgraded Bundler from 2.4.22 to 2.5.22 (ships with Ruby 3.3.12)

## Changes in 0.32.0

- Switched from fullstaq-ruby to official Ruby image
- Added jemalloc via `LD_PRELOAD`
- Added ARM64 (linux/arm64) support
