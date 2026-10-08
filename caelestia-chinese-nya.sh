#!/bin/bash
# ============================================================
#  caelestia-chinese-nya · 快速恢复 / 重装脚本
#  从 GitHub 拉取最新版萌猫语配置并一键安装
#  用法: bash ~/caelestia-chinese-nya.sh [--uninstall]
# ============================================================
set -e

REPO="monika-miaomiao/caelestia-Chinese-Nya"
TMP="$(mktemp -d)"

GREEN='\033[1;32m'; YELLOW='\033[1;33m'; RED='\033[1;31m'; NC='\033[0m'
ok()   { echo -e "${GREEN}[nya] ✔${NC} $*"; }
warn() { echo -e "${YELLOW}[nya] ⚠${NC} $*"; }
die()  { echo -e "${RED}[nya] ✘${NC} $*"; exit 1; }

if [ "$1" = "--uninstall" ]; then
    rm -rf "$HOME/.config/quickshell/caelestia"
    ok "已卸载萌猫语配置喵，重启 shell 即可恢复官方版"
    echo -e "  ${YELLOW}qs -c caelestia kill; caelestia shell -d${NC}"
    exit 0
fi

command -v curl >/dev/null 2>&1 || die "需要 curl"
command -v git >/dev/null 2>&1 || die "需要 git"

echo "正在从 GitHub 拉取 $REPO 最新版……"
git clone --depth 1 "https://github.com/$REPO.git" "$TMP/repo" || die "下载失败"

cd "$TMP/repo"
chmod +x install.sh
./install.sh

rm -rf "$TMP"
