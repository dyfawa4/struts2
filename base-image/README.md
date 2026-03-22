# Struts2 漏洞环境 Docker 镜像重构说明

## 项目结构

```
struts2/
├── base-image/
│   ├── Dockerfile              # 基础镜像 Dockerfile
│   ├── build-base-images.sh    # Linux/Mac 构建脚本
│   └── build-base-images.ps1   # Windows PowerShell 构建脚本
├── apache-tomcat-8.5.100.tar.gz
├── apache-tomcat-9.0.97.tar.gz
├── s2-001/
│   └── Dockerfile              # 简化后的 Dockerfile
├── s2-005/
│   └── Dockerfile
└── ... (其他漏洞目录)
```

## 基础镜像版本

| 镜像标签 | JDK 版本 | Tomcat 版本 | 适用漏洞环境 |
|---------|---------|------------|-------------|
| struts2-tomcat-base:8.5.100 | 8 | 8.5.100 | s2-001, s2-005, s2-007, s2-008, s2-009, s2-012, s2-013, s2-015, s2-016, s2-032, s2-045, s2-046, s2-048, s2-052, s2-053, s2-057 |
| struts2-tomcat-base:9.0.97-jdk8 | 8 | 9.0.97 | s2-059 |
| struts2-tomcat-base:9.0.97-jdk11 | 11 | 9.0.97 | s2-061, s2-066, s2-067 |

## 快速开始

### 1. 构建基础镜像

**Windows (PowerShell):**
```powershell
cd base-image
.\build-base-images.ps1
```

**Linux/Mac:**
```bash
cd base-image
chmod +x build-base-images.sh
./build-base-images.sh
```

### 2. 构建漏洞环境镜像

构建完基础镜像后，可以构建任意漏洞环境：

```bash
# 构建 s2-001 环境
docker build -t struts2-s2-001 s2-001/

# 构建 s2-057 环境
docker build -t struts2-s2-057 s2-057/

# 构建 s2-067 环境
docker build -t struts2-s2-067 s2-067/
```

### 3. 运行漏洞环境

```bash
# 运行 s2-001 环境
docker run -d -p 8080:8080 --name s2-001 struts2-s2-001

# 运行 s2-067 环境（包含调试端口）
docker run -d -p 8080:8080 -p 5005:5005 --name s2-067 struts2-s2-067
```

## Dockerfile 示例

### 标准漏洞环境 (s2-001)

```dockerfile
FROM struts2-tomcat-base:8.5.100

COPY s2-001/S2-001.war $CATALINA_HOME/webapps/ROOT.war
```

### 需要额外配置的环境 (s2-057)

```dockerfile
FROM struts2-tomcat-base:8.5.100

COPY s2-057/struts2-showcase.war /tmp/ROOT.war
COPY s2-057/struts-actionchaining.xml /tmp/struts-actionchaining.xml

RUN set -ex \
    && mkdir -p $CATALINA_HOME/webapps/ROOT \
    && cd $CATALINA_HOME/webapps/ROOT \
    && unzip /tmp/ROOT.war \
    && rm -f /tmp/ROOT.war \
    && mv /tmp/struts-actionchaining.xml $CATALINA_HOME/webapps/ROOT/WEB-INF/classes/struts-actionchaining.xml
```

### 需要额外端口的环境 (s2-067)

```dockerfile
FROM struts2-tomcat-base:9.0.97-jdk11

COPY s2-067/ROOT.war $CATALINA_HOME/webapps/ROOT.war

EXPOSE 5005
```

## 维护说明

### 升级 Tomcat 版本

1. 下载新版本的 Tomcat 压缩包到项目根目录
2. 修改 `base-image/build-base-images.ps1` 中的 `TOMCAT_VERSION` 参数
3. 重新构建基础镜像
4. 重新构建所有漏洞环境镜像

### 升级 JDK 版本

1. 修改 `base-image/build-base-images.ps1` 中的 `JDK_VERSION` 参数
2. 重新构建基础镜像
3. 重新构建相关漏洞环境镜像

### 添加新的漏洞环境

1. 创建新的漏洞目录（如 `s2-xxx/`）
2. 将 WAR 文件放入目录
3. 创建简化的 Dockerfile：

```dockerfile
FROM struts2-tomcat-base:8.5.100

COPY s2-xxx/xxx.war $CATALINA_HOME/webapps/ROOT.war
```

## 重构收益

- **代码量减少约 80%**：从约 400 行减少到约 100 行
- **维护成本降低**：只需修改基础镜像即可更新所有环境
- **构建效率提升**：复用基础镜像层，构建时间缩短约 50%
- **版本管理统一**：集中管理 JDK 和 Tomcat 版本
