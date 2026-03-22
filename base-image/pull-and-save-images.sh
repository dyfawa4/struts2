#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
IMAGES_DIR="$PROJECT_ROOT/images"

mkdir -p "$IMAGES_DIR"

echo "=== Pulling Docker Base Images ==="

echo ""
echo "Pulling eclipse-temurin:8-jdk..."
docker pull eclipse-temurin:8-jdk

echo ""
echo "Pulling eclipse-temurin:11-jdk..."
docker pull eclipse-temurin:11-jdk

echo ""
echo "=== Saving Docker Images to Tar Files ==="

echo ""
echo "Saving eclipse-temurin:8-jdk..."
docker save eclipse-temurin:8-jdk | gzip > "$IMAGES_DIR/eclipse-temurin-8-jdk.tar.gz"

echo ""
echo "Saving eclipse-temurin:11-jdk..."
docker save eclipse-temurin:11-jdk | gzip > "$IMAGES_DIR/eclipse-temurin-11-jdk.tar.gz"

echo ""
echo "=== Images saved to $IMAGES_DIR ==="
ls -lh "$IMAGES_DIR"
