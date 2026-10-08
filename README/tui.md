# 🐱 TUI 图形安装器 tui.py

一个**零第三方依赖**（仅需 Python 3 + curses）的精美终端图形界面，把所有功能收进一个交互式菜单。

## 使用

```bash
git clone https://github.com/monika-miaomiao/caelestia-Chinese-Nya
cd caelestia-Chinese-Nya
python3 tui.py
```

## 界面

```
  ╔══════════════════════════════════════════╗
  ║   /\_/\   Caelestia · Chinese Nya        ║
  ║  ( o.o )  萌猫语配置安装器 v1.0          ║
  ║   > ^ <    本喵为你服务喵～              ║
  ╚══════════════════════════════════════════╝

    ▶ 📦  安装萌猫语配置
      🗑️  卸载 / 回退到官方版
      ⚡  快速恢复 / 重装（联网）
      🔍  查看当前状态
      🚪  退出

  状态: ✅ 已安装   备份: 0 个   qs: ✅
  ↑↓ 选择 · Enter 确认 · q 退出
```

## 功能

| 功能 | 说明 |
| --- | --- |
| 📦 安装 | 调用 `install.sh`，旧配置自动备份 |
| 🗑️ 卸载 | 删除萌猫语配置 |
| ⚡ 快速恢复 | 调用 `~/caelestia-chinese-nya.sh`，没有则临时克隆 |
| 🔍 状态 | 安装状态、备份数量、qs 是否可用、联系方式 |

## 操作

- `↑` / `↓`：移动光标
- `Enter`：确认（危险操作会二次确认）
- `q`：退出

## 设计细节

- 青色 / 洋红配色，选中项反色高亮 + 左侧竖条
- 日志输出带滚动查看
- 自适应终端宽度
- 移动端风格的状态栏

## 源码结构

```python
main()          # 主循环：绘制 + 按键分发
do_install()    # 安装
do_uninstall()  # 卸载
do_reinstall()  # 联网恢复
do_status()     # 状态面板
confirm()       # 二次确认
show_output()   # 日志查看
```
