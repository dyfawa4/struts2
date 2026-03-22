#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
IMAGES_DIR="$PROJECT_ROOT/images"

echo "=== Loading Docker Images from Tar Files ==="

if [ ! -d "$IMAGES_DIR" ]; then
    echo "Error: Images directory not found at $IMAGES_DIR"
    echo "Please run pull-and-save-images.sh first on a machine with internet access."
    exit 1
fi

echo ""
echo "Loading eclipse-temurin:8-jdk..."
if [ -f "$IMAGES_DIR/eclipse-temurin-8-jdk.tar.gz" ]; then
    docker load < "$IMAGES_DIR/eclipse-temurin-8-jdk.tar.gz"
else
    echo "Error: eclipse-temurin-8-jdk.tar.gz not found"
    exit 1
fi

echo ""
echo "Loading eclipse-temurin:11-jdk..."
if [ -f "$IMAGES_DIR/eclipse-temurin-11-jdk.tar.gz" ]; then
    docker load < "$IMAGES_DIR/eclipse-temurin-11-jdk.tar.gz"
else
    echo "Error: eclipse-temurin-11-jdk.tar.gz not found"
    exit 1
fi

echo ""
echo "=== Building Struts2 Tomcat Base Images ==="

cd "$PROJECT_ROOT"

echo ""
echo "Building Tomcat 8.5.100 with JDK 8..."
docker build --build-arg JDK_VERSION=8 --build-arg TOMCAT_VERSION=8.5.100 \
  -t struts2-tomcat-base:8.5.100 \
  -f base-image/Dockerfile \
  .

echo ""
echo "Building Tomcat 9.0.97 with JDK 8..."
docker build --build-arg JDK_VERSION=8 --build-arg TOMCAT_VERSION=9.0.97 \
  -t struts2-tomcat-base:9.0.97-jdk8 \
  -f base-image/Dockerfile \
  .

echo ""
echo "Building Tomcat 9.0.97 with JDK 11..."
docker build --build-arg JDK_VERSION=11 --build-arg TOMCAT_VERSION=9.0.97 \
  -t struts2-tomcat-base:9.0.97-jdk11 \
  -f base-image/Dockerfile \
  .

echo ""
echo "=== All images loaded and built successfully ==="
docker images | grep -E "eclipse-temurin|struts2-tomcat-base"
