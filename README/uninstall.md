# ↩️ 卸载与回退 uninstall.sh

删除萌猫语配置，并可选择恢复安装前自动备份的旧配置。

## 使用

```bash
cd caelestia-Chinese-Nya
chmod +x uninstall.sh
./uninstall.sh
```

## 脚本流程

1. 删除 `~/.config/quickshell/caelestia`
2. 查找最近的备份 `caelestia.bak.*`
3. 交互询问：**是否恢复旧配置？**
   - 输入 `y` → 恢复备份
   - 输入 `n` → 保留备份，日志中显示备份名
4. 提示重启 shell

## 手动回退（不用脚本）

```bash
# 删除萌猫语配置，回落到 /etc 官方英文版
rm -rf ~/.config/quickshell/caelestia

# 或者恢复某次备份
mv ~/.config/quickshell/caelestia.bak.20261009-010000 ~/.config/quickshell/caelestia
```

## 生效

```bash
qs -c caelestia kill; caelestia shell -d
```

> 💡 Caelestia 会优先读取 `~/.config/quickshell/caelestia`；该目录不存在时自动回落到系统自带的 `/etc/xdg/quickshell/caelestia`。
