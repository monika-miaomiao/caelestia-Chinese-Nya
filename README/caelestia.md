# 🐾 萌猫语配置本体

`caelestia/` 目录是从 `/etc/xdg/quickshell/caelestia` 完整拷贝而来的 Caelestia Shell 配置，并把其中 **所有用户可见文案** 逐一翻译成了萌猫语。

## 翻译范围

- 任务栏（时钟、音量、网络、蓝牙、电池、托盘）
- 启动器与全屏搜索
- 仪表盘（媒体播放器、性能小部件）
- 侧栏与通知中心
- 窗口详情、屏幕录制器、计算器、表情选择器
- 全部设置页面（Nexus 设置）
- 锁屏与登录相关提示

## 翻译规则

| 规则 | 示例 |
| --- | --- |
| 第一人称 → 本喵 | 我 → 本喵 |
| 句尾加喵 | 设置 → 设置喵 |
| 占位符保留 | `%1`、`%n`、`%1 (%2)` |
| 单位符号保留 | `°C`、`Mbps`、`GHz`、`KiB` |
| 专有名词保留 | VPN、Wi-Fi、Bluetooth、SSH、DNS |

## 文件结构

```
caelestia/
├── shell.qml            # 入口
├── components/          # 通用组件（按钮、卡片、弹窗…）
├── modules/             # 各功能模块
│   ├── bar/             # 任务栏
│   ├── launcher/        # 启动器
│   ├── dashboard/       # 仪表盘
│   ├── background/      # 桌面壁纸
│   ├── lock/            # 锁屏
│   └── nexus/           # 设置中心
├── services/            # 后台服务（音频、网络、天气…）
├── utils/               # 工具（字符串、时间、路径…）
└── assets/              # 字体、默认壁纸、图标
```

## 为什么只改文字、不改逻辑？

所有文案都包裹在 `Tr.tr(...)` 系列函数中，Quickshell 启动时会用内置翻译器解析。我们只替换引号内的字符串，因此：

- `.arg()` 参数拼接不受影响
- 布局计算（字符串长度影响宽度的极少数情况）基本不变
- 功能逻辑零改动

## 自定义方法

```bash
# 找到所有可翻译位置
grep -rn 'Tr\.tr' ~/.config/quickshell/caelestia --include='*.qml'

# 修改后重启
qs -c caelestia kill; caelestia shell -d
```

> 💡 想改回某个词的官方说法也行，本喵不强求统一喵。
