#!/bin/bash
set -e

VERSION=${1:?Usage: ./sync-to-ecr.sh <version>}
SOURCE="polydice/base"
TARGET="public.ecr.aws/z1n0q3w1/base"

# Check AWS permissions
if ! aws ecr-public get-authorization-token --region us-east-1 &>/dev/null; then
  echo "❌ No permission to push to ECR Public. Run 'aws configure' first."
  exit 1
fi

# Login to ECR Public
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws

# Sync tags
for TAG in "${VERSION}" "${VERSION}-testing"; do
  echo "🔄 Syncing ${TAG}..."
  docker pull ${SOURCE}:${TAG} --platform linux/amd64
  docker tag ${SOURCE}:${TAG} ${TARGET}:${TAG}
  docker push ${TARGET}:${TAG}
  
  # Also sync ARM64
  docker pull ${SOURCE}:${TAG} --platform linux/arm64
  docker tag ${SOURCE}:${TAG} ${TARGET}:${TAG}-arm64
  docker push ${TARGET}:${TAG}-arm64
done

echo "✅ Synced ${VERSION} to ECR Public (amd64 + arm64)"
