#!/bin/bash
# caelestia-Chinese-Nya 一键安装脚本
# 将萌猫语化的 caelestia shell 安装到 ~/.config/quickshell/caelestia
set -e

DEST="$HOME/.config/quickshell"
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/caelestia"

if [ ! -d "$SRC" ]; then
    echo "错误：找不到 caelestia 目录，请先完整克隆本仓库。"
    exit 1
fi

mkdir -p "$DEST"
if [ -d "$DEST/caelestia" ]; then
    echo "备份旧配置到 $DEST/caelestia.bak"
    rm -rf "$DEST/caelestia.bak"
    mv "$DEST/caelestia" "$DEST/caelestia.bak"
fi
cp -r "$SRC" "$DEST/caelestia"
echo "安装完成喵！重启 shell 生效："
echo "  qs -c caelestia kill; caelestia shell -d"
