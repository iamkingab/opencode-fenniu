#!/bin/bash
set -e

# OpenCode 飞牛OS 一键安装脚本
# 自动下载、安装、配置

VERSION=1.17.8
REPO="anomalyco/opencode"
INSTALL_DIR="/opt/opencode"
BIN_DIR="/usr/local/bin"

echo "=========================================="
echo "  OpenCode 飞牛OS 安装脚本 v${VERSION}"
echo "=========================================="
echo ""

# 检查 root 权限
if [ "$EUID" -ne 0 ]; then
    echo "❌ 请使用 sudo 运行"
    echo "   sudo ./install.sh"
    exit 1
fi

# 检测架构
echo "📋 检测系统架构..."
ARCH=$(uname -m)
case $ARCH in
    x86_64|amd64)
        ARCH_FILE="linux-x64"
        echo "   ✓ x86_64 (Intel/AMD)"
        ;;
    aarch64|arm64)
        ARCH_FILE="linux-arm64"
        echo "   ✓ ARM64"
        ;;
    *)
        echo "   ❌ 不支持的架构: $ARCH"
        exit 1
        ;;
esac

# 检查/安装 Node.js
echo ""
echo "📋 检查 Node.js..."
if command -v node &> /dev/null; then
    NODE_VER=$(node --version)
    echo "   ✓ 已安装: $NODE_VER"
else
    echo "   ⚠️  未安装，正在自动安装..."
    
    if command -v apt-get &> /dev/null; then
        apt-get update -qq
        apt-get install -y -qq curl
        curl -fsSL https://deb.nodesource.com/setup_18.x | bash - > /dev/null 2>&1
        apt-get install -y -qq nodejs
    elif command -v yum &> /dev/null; then
        yum install -y -q curl
        curl -fsSL https://rpm.nodesource.com/setup_18.x | bash - > /dev/null 2>&1
        yum install -y -q nodejs
    elif command -v dnf &> /dev/null; then
        dnf install -y -q curl
        curl -fsSL https://rpm.nodesource.com/setup_18.x | bash - > /dev/null 2>&1
        dnf install -y -q nodejs
    else
        echo "   ❌ 无法自动安装，请手动安装 Node.js >= 16"
        exit 1
    fi
    
    echo "   ✓ Node.js 安装完成: $(node --version)"
fi

# 下载 OpenCode
echo ""
echo "📥 下载 OpenCode ${VERSION}..."
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

DOWNLOAD_URL="https://github.com/${REPO}/releases/download/v${VERSION}/opencode-${ARCH_FILE}.tar.gz"
echo "   来源: $DOWNLOAD_URL"

if command -v wget &> /dev/null; then
    wget -q --show-progress "$DOWNLOAD_URL" -O opencode.tar.gz
elif command -v curl &> /dev/null; then
    curl -L --progress-bar "$DOWNLOAD_URL" -o opencode.tar.gz
else
    echo "   ❌ 需要 wget 或 curl"
    exit 1
fi

# 解压安装
echo ""
echo "📦 解压安装..."
tar xzf opencode.tar.gz
rm opencode.tar.gz

# 查找可执行文件
EXECUTABLE=$(find . -name "opencode" -type f -executable 2>/dev/null | head -1)
if [ -z "$EXECUTABLE" ]; then
    # 可能解压出的是目录
    if [ -d "opencode-"* ]; then
        cd opencode-*
        EXECUTABLE=$(find . -name "opencode" -type f -executable | head -1)
        mv "$EXECUTABLE" ../opencode
        cd ..
        rm -rf opencode-*
    fi
fi

if [ ! -f "opencode" ]; then
    echo "   ❌ 未找到 opencode 可执行文件"
    exit 1
fi

chmod +x opencode
ln -sf "$INSTALL_DIR/opencode" "$BIN_DIR/opencode"

# 验证
echo ""
echo "✅ 安装完成！"
echo ""

if command -v opencode &> /dev/null; then
    echo "📍 安装信息:"
    echo "   位置: $INSTALL_DIR/opencode"
    echo "   命令: opencode"
    echo ""
    echo "🚀 使用方法:"
    echo "   opencode                  # 启动"
    echo "   opencode /path/to/project # 指定目录"
    echo "   opencode --help           # 帮助"
else
    echo "⚠️  安装完成，但命令未找到"
    echo "   请检查 PATH: export PATH=\"$BIN_DIR:\$PATH\""
fi

echo ""
echo "=========================================="
