# ⚡ 快速恢复脚本 caelestia-chinese-nya.sh

配置损坏、被误删、或想重装最新版时，**一条命令**搞定，无需手动克隆仓库。

## 安装到本机

```bash
curl -fsSL https://raw.githubusercontent.com/monika-miaomiao/caelestia-Chinese-Nya/main/caelestia-chinese-nya.sh -o ~/caelestia-chinese-nya.sh
chmod +x ~/caelestia-chinese-nya.sh
```

## 使用

```bash
# 重装 / 恢复最新版
bash ~/caelestia-chinese-nya.sh

# 快速卸载
bash ~/caelestia-chinese-nya.sh --uninstall
```

## 工作原理

```
git clone --depth 1 https://github.com/.../caelestia-Chinese-Nya  (浅克隆到临时目录)
        │
        └──> bash install.sh   (自动备份 + 安装 + 校验)
                │
                └──> 清理临时目录
```

## 依赖

- `curl`（下载脚本时）
- `git`
- 网络连接

## 适合场景

- 升级系统后配置异常
- 误删 `~/.config/quickshell/caelestia`
- 想体验最新翻译（仓库更新后）
