# Base

Polydice's base docker image for Rails applications.

## Variants

- `x.y.z` - Standard image for running on production
- `x.y.z-testing` - Image for testing which includes additional packages.

## Architectures

- `linux/amd64` (x86_64)
- `linux/arm64` (Graviton, Apple Silicon)

## Versions

| Version | Ruby  | Node.js | Yarn    | Bundler | pnpm  | ARM64 |
|---------|-------|---------|---------|---------|-------|-------|
| 0.32.0  | 2.7.8 | 18.18.0 | 1.22.22 | 2.4.20  | 9.9.0 | ✅    |
| 0.31.2  | 2.7.8 | 18.18.0 | 1.22.22 | 2.4.20  | 9.9.0 | ❌    |
| 0.31.1  | 2.7.8 | 18.18.0 | 1.22.19 | 2.4.20  | 8.8.0 | ❌    |
| 0.31.0  | 2.7.7 | 18.18.0 | 1.22.19 | 2.4.5   | 8.8.0 | ❌    |
| 0.30.3  | 2.7.7 | 14.21.2 | 1.22.19 | 2.4.5   |       | ❌    |

## Release

1. Update version in README.md
2. Commit and push tag:
   ```bash
   git tag 0.32.0
   git push origin 0.32.0
   ```
3. Wait for GitHub Actions to build and push to DockerHub
4. Sync to ECR Public:
   ```bash
   ./sync-to-ecr.sh 0.32.0
   ```

## Changes in 0.32.0

- Switched from fullstaq-ruby to official Ruby image
- Added jemalloc via `LD_PRELOAD`
- Added ARM64 (linux/arm64) support
