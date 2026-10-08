#!/bin/bash
# ============================================================
#  caelestia-Chinese-Nya · 卸载 / 回退脚本
#  删除萌猫语配置，并可选恢复最近一次安装前的备份
# ============================================================
set -e

GREEN='\033[1;32m'; YELLOW='\033[1;33m'; RED='\033[1;31m'; BLUE='\033[1;34m'; NC='\033[0m'
say()  { echo -e "${BLUE}[caelestia-nya]${NC} $*"; }
ok()   { echo -e "${GREEN}[caelestia-nya] ✔${NC} $*"; }
warn() { echo -e "${YELLOW}[caelestia-nya] ⚠${NC} $*"; }
die()  { echo -e "${RED}[caelestia-nya] ✘${NC} $*"; exit 1; }

DEST_DIR="$HOME/.config/quickshell"
DEST="$DEST_DIR/caelestia"

say "开始卸载 萌猫语 Caelestia Shell 配置喵～"

if [ -d "$DEST" ]; then
    rm -rf "$DEST"
    ok "已删除萌猫语配置喵"
else
    warn "未找到萌猫语配置（$DEST），可能已经卸载过了"
fi

# 恢复最近一次备份
BACKUP="$(ls -dt "$DEST_DIR"/caelestia.bak.* 2>/dev/null | head -n1)"
if [ -n "$BACKUP" ]; then
    echo
    read -p "检测到备份：$(basename "$BACKUP")，是否恢复？(y/N) " ans
    case "$ans" in
        [yY]|[yY][eE][sS])
            mv "$BACKUP" "$DEST"
            ok "已恢复旧配置喵"
            ;;
        *)
            say "保留备份：$(basename "$BACKUP")"
            ;;
    esac
else
    say "没有可恢复的备份喵"
fi

echo
ok "卸载完成喵！重启 shell 生效："
echo -e "  ${YELLOW}qs -c caelestia kill; caelestia shell -d${NC}"
echo -e "  交流 QQ 群：${GREEN}1126854380${NC}"
