#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_ROOT"

echo "=== Building Struts2 Tomcat Base Images ==="

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
echo "=== Base images built successfully ==="
docker images | grep struts2-tomcat-base
