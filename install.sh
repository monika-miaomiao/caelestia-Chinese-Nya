#!/bin/bash
# ============================================================
#  caelestia-Chinese-Nya · 一键安装脚本
#  把萌猫语化的 Caelestia Shell 装进 ~/.config/quickshell/caelestia
# ============================================================
set -e

# ---------- 输出小工具 ----------
GREEN='\033[1;32m'; YELLOW='\033[1;33m'; RED='\033[1;31m'; BLUE='\033[1;34m'; NC='\033[0m'
say()  { echo -e "${BLUE}[caelestia-nya]${NC} $*"; }
ok()   { echo -e "${GREEN}[caelestia-nya] ✔${NC} $*"; }
warn() { echo -e "${YELLOW}[caelestia-nya] ⚠${NC} $*"; }
die()  { echo -e "${RED}[caelestia-nya] ✘${NC} $*"; exit 1; }

# ---------- 定位 ----------
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/caelestia"
DEST_DIR="$HOME/.config/quickshell"
DEST="$DEST_DIR/caelestia"
BAK="$DEST_DIR/caelestia.bak.$(date +%Y%m%d-%H%M%S)"

say "开始安装 萌猫语 Caelestia Shell 配置喵～"

# ---------- 检查 ----------
[ -d "$SRC" ] || die "找不到 caelestia 源目录：$SRC（请完整克隆本仓库后运行）"

if command -v qs >/dev/null 2>&1; then
    if ! qs --list-configs 2>/dev/null | grep -qx caelestia; then
        warn "未检测到名为 caelestia 的 Quickshell 配置，本脚本针对 Caelestia Shell 设计"
    fi
else
    warn "未在 PATH 中找到 qs（Quickshell），请确认已安装 caelestia-shell"
fi

# ---------- 备份 ----------
if [ -d "$DEST" ]; then
    say "检测到已有配置，备份到：$(basename "$BAK")"
    mv "$DEST" "$BAK" || die "备份失败"
    ok "备份完成喵"
fi

# ---------- 安装 ----------
mkdir -p "$DEST_DIR"
say "正在拷贝配置到 $DEST ……"
cp -r "$SRC" "$DEST" || die "拷贝失败"
ok "安装完成喵！"

# ---------- 校验 ----------
if [ -f "$DEST/shell.qml" ]; then
    ok "配置校验通过喵"
else
    die "安装异常：未找到 shell.qml，请检查仓库完整性"
fi

# ---------- 收尾 ----------
echo
ok "全部搞定喵！接下来重启 shell 生效："
echo -e "  ${YELLOW}qs -c caelestia kill; caelestia shell -d${NC}"
echo
echo -e "  想回退到旧配置？运行：${GREEN}./uninstall.sh${NC}"
echo -e "  交流 QQ 群：${GREEN}1126854380${NC}"
