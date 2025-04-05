#!/bin/bash

# 设置环境变量
export GO_ENV=production
export PORT=8090

# 输出启动信息
echo "Starting Coldchain Backend Service..."
echo "Environment: $GO_ENV"
echo "Port: $PORT"

# 启动服务
nohup ./coldchain-backend > backend.log 2>&1 &

# 获取进程ID
PID=$!
echo "Service started with PID: $PID"
echo "Log file: backend.log"

# 等待几秒检查服务是否成功启动
sleep 3
if ps -p $PID > /dev/null; then
  echo "Service started successfully!"
else
  echo "Service failed to start. Check backend.log for details."
  exit 1
fi

# 输出使用说明
echo "To stop the service, run: kill $PID"
echo "To view logs, run: tail -f backend.log" 