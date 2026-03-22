$ErrorActionPreference = "Stop"

$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$PROJECT_ROOT = Split-Path -Parent $SCRIPT_DIR

Set-Location $PROJECT_ROOT

Write-Host "=== Building Struts2 Tomcat Base Images ===" -ForegroundColor Green

Write-Host ""
Write-Host "Building Tomcat 8.5.100 with JDK 8..."
docker build --build-arg JDK_VERSION=8 --build-arg TOMCAT_VERSION=8.5.100 `
  -t struts2-tomcat-base:8.5.100 `
  -f base-image/Dockerfile .

Write-Host ""
Write-Host "Building Tomcat 9.0.97 with JDK 8..."
docker build --build-arg JDK_VERSION=8 --build-arg TOMCAT_VERSION=9.0.97 `
  -t struts2-tomcat-base:9.0.97-jdk8 `
  -f base-image/Dockerfile .

Write-Host ""
Write-Host "Building Tomcat 9.0.97 with JDK 11..."
docker build --build-arg JDK_VERSION=11 --build-arg TOMCAT_VERSION=9.0.97 `
  -t struts2-tomcat-base:9.0.97-jdk11 `
  -f base-image/Dockerfile .

Write-Host ""
Write-Host "=== Base images built successfully ===" -ForegroundColor Green
docker images | Select-String struts2-tomcat-base
