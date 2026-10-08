# 🛠️ 安装脚本 install.sh

一键把萌猫语配置装进 `~/.config/quickshell/caelestia`。

## 使用

```bash
git clone https://github.com/monika-miaomiao/caelestia-Chinese-Nya
cd caelestia-Chinese-Nya
chmod +x install.sh
./install.sh
```

## 脚本流程

1. **环境检查**
   - 确认 `caelestia` 源目录存在
   - 检测 `qs`（Quickshell）是否在 PATH 中
   - 检测是否存在名为 `caelestia` 的 Quickshell 配置
2. **自动备份**
   - 已存在的 `~/.config/quickshell/caelestia` 会被移动为
     `caelestia.bak.年月日-时分秒`（精确到秒，不怕覆盖）
3. **拷贝安装**
   - `cp -r caelestia ~/.config/quickshell/`
4. **完整性校验**
   - 检查 `shell.qml` 是否存在，缺失即报错退出
5. **收尾提示**
   - 彩色输出重启命令与 QQ 群

## 输出示例

```
[caelestia-nya] 开始安装 萌猫语 Caelestia Shell 配置喵～
[caelestia-nya] ✔ 安装完成喵！
[caelestia-nya] ✔ 配置校验通过喵

[caelestia-nya] ✔ 全部搞定喵！接下来重启 shell 生效：
  qs -c caelestia kill; caelestia shell -d
```

## 特点

- 彩色日志（蓝=信息、绿=成功、黄=警告、红=错误）
- `set -e` 保证任何一步失败立即中止
- 不需要 root 权限
- 重复运行安全（每次先备份）
