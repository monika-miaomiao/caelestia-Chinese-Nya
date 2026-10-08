# Caelestia Shell · 萌猫语（Chinese Nya）配置

> 把你的 Caelestia Shell 变成会喵喵叫的本喵桌面喵！🐱

一套**纯手搓**的中文萌猫语化配置：所有界面文字翻译成中文，第一人称统一为「本喵」，句尾自带「喵」。

## ✨ 特色

- 🐾 **全界面中文化**：覆盖任务栏、启动器、仪表盘、侧栏、通知、弹窗、设置等全部 UI 文本
- 🐱 **萌猫语**：「我」→「本喵」，所有句子以「喵」结尾
- 🎯 **零侵入**：安装在 `~/.config/quickshell/caelestia`，不动系统 `/etc` 文件，升级不冲突
- ↩️ **可回退**：安装脚本自动备份旧配置，删掉目录即恢复原版
- 🔌 **无需 root**：纯用户级配置

## 📦 安装

### 方式一：一键脚本

```bash
git clone https://github.com/monika-miaomiao/caelestia-Chinese-Nya
cd caelestia-Chinese-Nya
./install.sh
```

### 方式二：手动

```bash
git clone https://github.com/monika-miaomiao/caelestia-Chinese-Nya
mkdir -p ~/.config/quickshell
cp -r caelestia-Chinese-Nya/caelestia ~/.config/quickshell/
```

### 生效

```bash
qs -c caelestia kill; caelestia shell -d
```

> Quickshell 有时会自动检测 `~/.config/quickshell` 下的改动并热重载，若没变化再手动重启。

## 🖼️ 效果示例

| 原文 | 萌猫语 |
| --- | --- |
| Settings | 设置喵 |
| Volume (muted) | 音量（静音）喵 |
| Connected to %1 | 已连接到 %1 喵 |
| Add network | 添加网络喵 |
| Wallpaper missing? | 壁纸缺失了喵？ |
| No notifications | 没有通知喵 |
| Fully charged! | 已充满！喵 |

## ⚠️ 注意事项

- 仅适用于 **Caelestia Shell**（caelestia-shell），其它桌面环境无效
- 翻译基于当前打包的 shell 版本，shell 更新后如有新文案需要重新汉化
- 部分格式占位符（`%1`、`%n`）、单位（`°C`、`Mbps`、`GHz`）和专有名词保留原样
- 安装脚本会把现有 `~/.config/quickshell/caelestia` 备份为 `caelestia.bak`

## 🛠️ 自定义

直接编辑 `~/.config/quickshell/caelestia/` 下的 `.qml` 文件，搜索 `Tr.tr("` 即可找到所有可翻译文案。改完重启 shell 生效。

## 💬 交流

- 🐱 **QQ 群：1126854380**
- 📮 Issues：[GitHub Issues](https://github.com/monika-miaomiao/caelestia-Chinese-Nya/issues)

## 📜 许可

衍生自 [caelestia-dots/shell](https://github.com/caelestia-dots/shell)（GPL-3.0-only），翻译内容同样遵循 GPL-3.0-only。

---

*本喵等你的 Star 喵～ ⭐*
