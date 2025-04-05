#!/bin/bash

# 设置颜色
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 输出带颜色的信息
info() {
  echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
  echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

# 检查命令是否存在
check_command() {
  if ! command -v $1 &> /dev/null; then
    error "$1 is not installed. Please install it first."
    exit 1
  fi
}

# 检查必要的命令
info "Checking required commands..."
check_command go
check_command node
check_command npm
check_command nginx

# 创建部署目录
info "Creating deployment directory..."
sudo mkdir -p /var/www/coldchain
sudo chown -R $USER:$USER /var/www/coldchain

# 部署后端
info "Deploying backend..."
cd backend
go mod download
go build -o coldchain-backend
chmod +x start.sh
./start.sh
cd ..

# 部署前端
info "Deploying frontend..."
cd showpage
npm install
npm run build
cd ..

# 配置Nginx
info "Configuring Nginx..."
sudo cp nginx.conf /etc/nginx/sites-available/coldchain
sudo ln -sf /etc/nginx/sites-available/coldchain /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx

# 检查服务状态
info "Checking service status..."
if pgrep -x "coldchain-backend" > /dev/null; then
  info "Backend service is running."
else
  error "Backend service failed to start. Check backend.log for details."
fi

if systemctl is-active --quiet nginx; then
  info "Nginx is running."
else
  error "Nginx failed to start. Check system logs for details."
fi

info "Deployment completed!"
info "You can access your application at http://123.57.22.188" 