# Struts2 漏洞靶场 - 离线版 / Struts2 Vulnerability Range - Offline Edition

[中文](#中文) | [English](#english)

---

<a name="中文"></a>
## 中文

### 项目简介

本项目基于 [Vulhub](https://github.com/vulhub/vulhub) 的 Struts2 漏洞靶场进行修改，主要解决以下问题：

1. **适配最新 Linux 系统** - 使用 Eclipse Temurin JDK 替代过时的 OpenJDK，解决 glibc 兼容性问题
2. **完全离线运行** - 内置所有依赖文件（JDK镜像、Tomcat、War文件），无需网络即可构建和运行
3. **避免网络问题** - 解决原版因网络问题导致无法启动靶场的问题

### 包含漏洞

| 靶场 | 漏洞名称 | Struts2版本 |
|------|----------|-------------|
| s2-001 | 远程代码执行 | 2.0.0-2.0.8 |
| s2-005 | 远程代码执行 | 2.0.0-2.1.8.1 |
| s2-007 | 用户输入过滤绕过 | 2.0.0-2.2.3 |
| s2-008 | 远程代码执行 | 2.1.0-2.3.1 |
| s2-009 | OGNL双表达式执行 | 2.1.0-2.3.1.1 |
| s2-012 | OGNL表达式注入 | 2.1.0-2.3.13 |
| s2-013 | URL标签注入 | 2.0.0-2.3.14.1 |
| s2-015 | URL标签注入 | 2.0.0-2.3.14.2 |
| s2-016 | URL标签注入 | 2.0.0-2.3.15 |
| s2-032 | 动态方法调用RCE | 2.3.20-2.3.28 |
| s2-045 | Jakarta Multipart RCE | 2.3.5-2.3.31 |
| s2-046 | Jakarta Multipart RCE | 2.3.5-2.3.31 |
| s2-048 | Struts Showcase RCE | 2.3.x |
| s2-052 | REST插件RCE | 2.1.2-2.3.33 |
| s2-053 | Freemarker RCE | 2.0.1-2.3.33 |
| s2-057 | Namespace RCE | 2.3.34 |
| s2-059 | OGNL表达式注入 | 2.0.0-2.5.20 |
| s2-061 | OGNL表达式注入 | 2.0.0-2.5.25 |
| s2-066 | 文件上传路径穿越 | 2.0.0-2.5.30 |
| s2-067 | 文件上传路径穿越 | 2.0.0-2.5.30 |

### 快速开始（完全离线）

```bash
# 1. 进入项目目录
cd struts2

# 2. 加载 Docker 镜像并构建基础镜像
chmod +x base-image/*.sh
./base-image/load-images-offline.sh

# 3. 启动靶场
cd s2-001
docker compose up -d

# 4. 访问靶场
# 浏览器打开 http://localhost:8080
```

### 目录结构

```
struts2/
├── images/                          # Docker基础镜像（已内置）
│   ├── eclipse-temurin-8-jdk.tar.gz
│   └── eclipse-temurin-11-jdk.tar.gz
├── apache-tomcat-8.5.100.tar.gz     # Tomcat 8（已内置）
├── apache-tomcat-9.0.97.tar.gz      # Tomcat 9（已内置）
├── base-image/
│   ├── Dockerfile
│   ├── load-images-offline.sh       # 加载镜像并构建基础镜像
│   └── build-base-images.sh         # 仅构建基础镜像
├── s2-001/ ~ s2-067/                # 20个漏洞靶场（war文件已内置）
└── README.md
```

### 常用命令

```bash
docker compose up -d        # 启动靶场
docker compose logs -f      # 查看日志
docker compose down         # 停止靶场
docker compose up -d --build # 重新构建
```

### 与原版 Vulhub 的区别

| 项目 | 原版 Vulhub | 本项目 |
|------|-------------|--------|
| JDK | OpenJDK 8u121 (glibc不兼容) | Eclipse Temurin 8/11 |
| Tomcat | 在线下载 | 内置本地文件 |
| War文件 | 在线下载 | 内置本地文件 |
| Docker镜像 | 在线拉取 | 内置本地文件 |
| 网络依赖 | 需要网络 | 完全离线 |
| 系统兼容性 | 旧版Linux | 最新Linux/Kali |

### 致谢

- [Vulhub](https://github.com/vulhub/vulhub) - 原始漏洞环境
- [Apache Struts](https://struts.apache.org/) - Struts2 框架
- [Eclipse Temurin](https://adoptium.net/) - JDK 发行版

---

<a name="english"></a>
## English

### Introduction

This project is a modified version of the [Vulhub](https://github.com/vulhub/vulhub) Struts2 vulnerability range, with the following improvements:

1. **Compatible with latest Linux systems** - Uses Eclipse Temurin JDK instead of outdated OpenJDK to solve glibc compatibility issues
2. **Fully offline operation** - All dependencies are built-in (JDK images, Tomcat, War files), no network required to build and run
3. **Avoid network issues** - Solves the problem of unable to start the range due to network issues in the original version

### Included Vulnerabilities

| Range | Vulnerability | Struts2 Version |
|-------|---------------|-----------------|
| s2-001 | Remote Code Execution | 2.0.0-2.0.8 |
| s2-005 | Remote Code Execution | 2.0.0-2.1.8.1 |
| s2-007 | User Input Filter Bypass | 2.0.0-2.2.3 |
| s2-008 | Remote Code Execution | 2.1.0-2.3.1 |
| s2-009 | OGNL Double Expression | 2.1.0-2.3.1.1 |
| s2-012 | OGNL Expression Injection | 2.1.0-2.3.13 |
| s2-013 | URL Tag Injection | 2.0.0-2.3.14.1 |
| s2-015 | URL Tag Injection | 2.0.0-2.3.14.2 |
| s2-016 | URL Tag Injection | 2.0.0-2.3.15 |
| s2-032 | Dynamic Method Invocation RCE | 2.3.20-2.3.28 |
| s2-045 | Jakarta Multipart RCE | 2.3.5-2.3.31 |
| s2-046 | Jakarta Multipart RCE | 2.3.5-2.3.31 |
| s2-048 | Struts Showcase RCE | 2.3.x |
| s2-052 | REST Plugin RCE | 2.1.2-2.3.33 |
| s2-053 | Freemarker RCE | 2.0.1-2.3.33 |
| s2-057 | Namespace RCE | 2.3.34 |
| s2-059 | OGNL Expression Injection | 2.0.0-2.5.20 |
| s2-061 | OGNL Expression Injection | 2.0.0-2.5.25 |
| s2-066 | File Upload Path Traversal | 2.0.0-2.5.30 |
| s2-067 | File Upload Path Traversal | 2.0.0-2.5.30 |

### Quick Start (Fully Offline)

```bash
# 1. Enter project directory
cd struts2

# 2. Load Docker images and build base images
chmod +x base-image/*.sh
./base-image/load-images-offline.sh

# 3. Start range
cd s2-001
docker compose up -d

# 4. Access range
# Open browser at http://localhost:8080
```

### Directory Structure

```
struts2/
├── images/                          # Docker base images (built-in)
│   ├── eclipse-temurin-8-jdk.tar.gz
│   └── eclipse-temurin-11-jdk.tar.gz
├── apache-tomcat-8.5.100.tar.gz     # Tomcat 8 (built-in)
├── apache-tomcat-9.0.97.tar.gz      # Tomcat 9 (built-in)
├── base-image/
│   ├── Dockerfile
│   ├── load-images-offline.sh       # Load images and build base images
│   └── build-base-images.sh         # Build base images only
├── s2-001/ ~ s2-067/                # 20 vulnerability ranges (war files built-in)
└── README.md
```

### Common Commands

```bash
docker compose up -d        # Start range
docker compose logs -f      # View logs
docker compose down         # Stop range
docker compose up -d --build # Rebuild
```

### Differences from Original Vulhub

| Item | Original Vulhub | This Project |
|------|-----------------|--------------|
| JDK | OpenJDK 8u121 (glibc incompatible) | Eclipse Temurin 8/11 |
| Tomcat | Download online | Built-in local files |
| War files | Download online | Built-in local files |
| Docker images | Pull online | Built-in local files |
| Network dependency | Required | Fully offline |
| System compatibility | Old Linux | Latest Linux/Kali |

### Acknowledgments

- [Vulhub](https://github.com/vulhub/vulhub) - Original vulnerability environment
- [Apache Struts](https://struts.apache.org/) - Struts2 framework
- [Eclipse Temurin](https://adoptium.net/) - JDK distribution

---

## License

This project is for educational purposes only. Use at your own risk.
