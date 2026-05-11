# OpenCode 飞牛OS 安装包

一键安装 [OpenCode](https://opencode.ai) 到飞牛OS (FenniuOS)。

## 🚀 快速安装

```bash
# 下载安装脚本
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/opencode-fenniu/main/install.sh -o install.sh

# 赋予执行权限
chmod +x install.sh

# 运行安装（需要 root）
sudo ./install.sh
```

或者克隆仓库：

```bash
git clone https://github.com/YOUR_USERNAME/opencode-fenniu.git
cd opencode-fenniu
sudo ./install.sh
```

## ✨ 特性

- ✅ **自动检测架构** - 支持 x86_64 和 ARM64
- ✅ **自动安装依赖** - Node.js 等自动配置
- ✅ **一键安装** - 无需手动下载或配置
- ✅ **适配飞牛OS** - 针对飞牛NAS优化

## 📋 系统要求

| 项目 | 要求 |
|------|------|
| 系统 | 飞牛OS / Linux |
| 架构 | x86_64 或 ARM64 |
| Node.js | >= 16 (自动安装) |
| 磁盘 | 100MB |

## 🔧 手动安装依赖

如果自动安装失败：

```bash
# Debian/Ubuntu 系
sudo apt-get update
sudo apt-get install -y curl wget tar nodejs npm

# CentOS/RHEL 系
sudo yum install -y curl wget tar nodejs npm
```

## 📍 安装位置

- 可执行文件: `/opt/opencode/opencode`
- 命令链接: `/usr/local/bin/opencode`

## 🗑️ 卸载

```bash
sudo rm /usr/local/bin/opencode
sudo rm -rf /opt/opencode
```

## ❓ 常见问题

### Q: 提示 "command not found"
```bash
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Q: Node.js 版本过低
```bash
# 升级 Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo bash -
sudo apt-get install -y nodejs
```

### Q: 下载速度慢
可以手动下载对应架构的文件，放到 `/opt/opencode/` 目录：
- x86_64: [opencode-linux-x64.tar.gz](https://github.com/anomalyco/opencode/releases/latest)
- ARM64: [opencode-linux-arm64.tar.gz](https://github.com/anomalyco/opencode/releases/latest)

## 📖 更多信息

- [OpenCode 官网](https://opencode.ai)
- [OpenCode GitHub](https://github.com/anomalyco/opencode)
- [飞牛NAS](https://www.flynas.cn)

## 📄 许可证

MIT
