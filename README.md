<div align="center">

# 🐱 Caelestia Shell · 萌猫语（Chinese Nya）配置

**把你的 Caelestia Shell 变成会喵喵叫的本喵桌面喵！**

一套**纯手搓**的中文萌猫语化配置：所有界面文字翻译成中文，第一人称统一为「本喵」，句尾自带「喵」。

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](LICENSE)
[![Shell](https://img.shields.io/badge/shell-caelestia--shell-pink.svg)](https://github.com/caelestia-dots/shell)
[![QQ 群](https://img.shields.io/badge/QQ%E7%BE%A4-1126854380-ff69b4.svg)](#%E4%BA%A4%E6%B5%81)

</div>

---

## 📖 目录

- [✨ 特色](#-特色)
- [🖼️ 效果示例](#-效果示例)
- [📦 安装](#-安装)
- [🗑️ 卸载 / 回退](#️-卸载--回退)
- [⚠️ 注意事项](#-注意事项)
- [🛠️ 自定义翻译](#-自定义翻译)
- [❓ 常见问题](#-常见问题)
- [🤝 贡献](#-贡献)
- [💬 交流](#-交流)

## 📚 项目背景

Caelestia 是一套基于 Quickshell 构建的流体化桌面 Shell，颜值极高，但官方界面默认只提供英文，对中文用户并不友好。本项目把 Shell 内全部 `Tr.tr` 文案逐一提取、手工翻译成接地气的「萌猫语」：既保留原文的功能语义，又让每个按钮、每条通知都带上本喵的口吻。翻译全程人工校对，未使用机翻直出，格式占位符与单位符号均逐一核对，确保 `.arg()` 参数拼接、列表渲染和状态判断不受影响。

## 🖥️ 适用环境

- **桌面环境**：Hyprland（官方搭配），理论上任何 Wayland 合成器均可运行
- **必要组件**：`caelestia-shell`、Quickshell（`qs`）
- **推荐发行版**：Arch Linux / CachyOS / Fedora 等已打包 caelestia-shell 的发行版
- **不适用**：Niri、i3、Sway 等使用其它配置体系的桌面（请使用对应项目自带的汉化方案）

## ✨ 特色

| | |
| --- | --- |
| 🐾 **全界面中文化** | 覆盖任务栏、启动器、仪表盘、侧栏、通知中心、弹窗、设置等全部 UI 文本 |
| 🐱 **萌猫语规则** | 第一人称「我/我的」→「本喵/本喵的」，所有句子以「喵」结尾 |
| 🎯 **零侵入安装** | 只写入 `~/.config/quickshell/caelestia`，不修改系统 `/etc` 目录 |
| 🛡️ **自动备份** | 安装脚本自动备份旧配置，带时间戳，不怕误操作 |
| ↩️ **一键回退** | 附带 `uninstall.sh`，卸载时可恢复备份 |
| 🔌 **无需 root** | 纯用户级配置，任何发行版都能用 |
| 🧩 **更新安全** | 系统升级覆盖 `/etc` 配置不影响本配置；想恢复官方版删掉目录即可 |

## 🖼️ 效果示例

| 原文 | 萌猫语 |
| --- | --- |
| Settings | 设置喵 |
| Volume (muted) | 音量（静音）喵 |
| Volume (%1%) | 音量（%1%）喵 |
| Connected to %1 | 已连接到 %1 喵 |
| Add network | 添加网络喵 |
| Wallpaper missing? | 壁纸缺失了喵？ |
| No notifications | 没有通知喵 |
| Fully charged! | 已充满！喵 |
| Wi-Fi disabled | Wi-Fi 已禁用喵 |
| Select a wallpaper | 选择壁纸喵 |
| VPN connected | VPN 已连接喵 |
| Now playing | 正在播放喵 |

## 📦 安装

### 方式一：一键脚本（推荐）

```bash
git clone https://github.com/monika-miaomiao/caelestia-Chinese-Nya
cd caelestia-Chinese-Nya
chmod +x install.sh
./install.sh
```

脚本会自动完成：检查环境 → 备份旧配置 → 拷贝新配置 → 校验完整性。

### 方式二：手动安装

```bash
git clone https://github.com/monika-miaomiao/caelestia-Chinese-Nya
mkdir -p ~/.config/quickshell
cp -r caelestia-Chinese-Nya/caelestia ~/.config/quickshell/
```

### 使配置生效

```bash
qs -c caelestia kill; caelestia shell -d
```

> 💡 Quickshell 会监视 `~/.config/quickshell` 下的改动，有时会自动热重载；若界面没变化，再手动重启 shell。

### 验证是否成功

打开 Caelestia 的任意菜单（例如启动器或设置），如果文字带有「喵」，就说明安装成功喵！

## ⚡ 快速恢复 / 重装

如果配置损坏或被误删，无需重新克隆仓库，一条命令即可恢复：

```bash
# 下载并执行（推荐先放到 ~/caelestia-chinese-nya.sh）
curl -fsSL https://raw.githubusercontent.com/monika-miaomiao/caelestia-Chinese-Nya/main/caelestia-chinese-nya.sh -o ~/caelestia-chinese-nya.sh
bash ~/caelestia-chinese-nya.sh

# 卸载
bash ~/caelestia-chinese-nya.sh --uninstall
```

脚本会自动从 GitHub 拉取最新版并调用 `install.sh`（含自动备份）。

## 🗑️ 卸载 / 回退

```bash
cd caelestia-Chinese-Nya
chmod +x uninstall.sh
./uninstall.sh
```

卸载时会提示是否恢复安装前自动备份的旧配置，选择 `y` 即可回到原版。

也可以手动回退：

```bash
rm -rf ~/.config/quickshell/caelestia
```

删除后 Caelestia 会回落到系统自带的 `/etc/xdg/quickshell/caelestia`（官方英文版）。

## ⚠️ 注意事项

- **仅适用于 Caelestia Shell**（`caelestia-shell`，基于 Quickshell + Hyprland），其它桌面环境无效
- 翻译基于当前打包的 shell 版本；shell 更新后若出现新文案，需要重新汉化
- 格式占位符（`%1`、`%n`）、单位符号（`°C`、`°F`、`Mbps`、`GHz`、`KiB`）以及专有名词（VPN、Wi-Fi、Bluetooth、SSH 等）保留原样，避免破坏功能
- 安装脚本会把现有的 `~/.config/quickshell/caelestia` 备份为 `caelestia.bak.时间戳`
- 如果你之前自己改过 `~/.config/quickshell/caelestia`，请先手动备份，安装前会再次自动备份

## 🛠️ 自定义翻译

所有可翻译文案都在 `Tr.tr("...")` / `Tr.trCtx(...)` / `Tr.trN(...)` 里：

```bash
grep -rn 'Tr\.tr' ~/.config/quickshell/caelestia --include='*.qml'
```

直接用编辑器打开对应的 `.qml` 文件，改引号里的中文即可，改完重启 shell 生效。想改回某个词的官方翻译也行，本喵不强求统一喵。

## ❓ 常见问题

<details>
<summary>安装后界面没有变化？</summary>

确认 `~/.config/quickshell/caelestia` 存在且包含 `shell.qml`，然后执行：

```bash
qs -c caelestia kill; caelestia shell -d
```

如果还不行，检查是否运行的是 DMS/niri 等其它桌面环境。
</details>

<details>
<summary>为什么有些词还是英文？</summary>

格式占位符、单位、专有名词和少数纯技术模板（如 `%1 (%2)`、`12-hour`）会刻意保留原样，防止 `.arg()` 拼接、布局计算或解析出错。
</details>

<details>
<summary>会影响 Caelestia 的壁纸 / 配色功能吗？</summary>

不会。本配置只修改 UI 文字，不改动壁纸、配色方案、快捷键等任何逻辑。
</details>

<details>
<summary>Caelestia 更新后还能用吗？</summary>

`/etc` 下的官方配置会被包管理器覆盖，但 `~/.config/quickshell/caelestia` 优先级更高且不会被覆盖，所以通常不受影响。若新版 shell 结构变化导致异常，删除该目录即可恢复。
</details>

## 🤝 贡献

翻译有更好的说法？想补充新版本文案？欢迎提 PR 或在 QQ 群里讨论喵！

## 📜 许可证

衍生自 [caelestia-dots/shell](https://github.com/caelestia-dots/shell)（GPL-3.0-only），本翻译内容同样遵循 GPL-3.0-only。

## 💬 联系

- 🐱 **QQ 群：1126854380**
- 📺 **B站**：https://b23.tv/AdaW44h
- 📧 **邮箱**：xiaoran_official@hotmail.com
- 📮 问题反馈：[GitHub Issues](https://github.com/monika-miaomiao/caelestia-Chinese-Nya/issues)
- 🌐 上游项目：[caelestia-dots](https://github.com/caelestia-dots)

---

<div align="center">

*本喵等你的 Star 喵～ ⭐*

</div>
