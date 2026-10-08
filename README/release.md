# 📦 Release 与打包发布

## 当前版本

| 版本 | 附件 | 说明 |
| --- | --- | --- |
| v1.0 | `caelestia-chinese-nyaV1.0.zip` | 首个正式版，含全部脚本 + TUI |

下载地址：

```
https://github.com/monika-miaomiao/caelestia-Chinese-Nya/releases/download/v1.0/caelestia-chinese-nyaV1.0.zip
```

## zip 内容

```
caelestia-chinese-nyaV1.0.zip
├── caelestia/              # 萌猫语化配置
├── install.sh              # 安装
├── uninstall.sh            # 卸载 / 回退
├── caelestia-chinese-nya.sh  # 快速恢复
├── tui.py                  # TUI 安装器
├── README.md               # 项目说明
└── .gitignore
```

## 打包命令

```bash
cd ~/caelestia-Chinese-Nya
zip -qr caelestia-chinese-nyaV1.0.zip \
    caelestia install.sh uninstall.sh \
    caelestia-chinese-nya.sh tui.py README.md .gitignore
```

## 发布流程

1. 打 tag 并推送：

   ```bash
   git tag v1.0 && git push origin v1.0
   ```

2. 创建 Release（API 方式）：

   ```bash
   curl -X POST \
     -H "Authorization: Bearer <TOKEN>" \
     -H "Content-Type: application/json" \
     -d '{"tag_name":"v1.0","name":"caelestia-Chinese-Nya V1.0","body":"更新说明"}' \
     "https://api.github.com/repos/monika-miaomiao/caelestia-Chinese-Nya/releases"
   ```

3. 上传附件（先删除同名旧资产再传，避免重复）：

   ```bash
   curl -X POST \
     -H "Authorization: Bearer <TOKEN>" \
     -H "Content-Type: application/zip" \
     --data-binary @caelestia-chinese-nyaV1.0.zip \
     "https://uploads.github.com/repos/monika-miaomiao/caelestia-Chinese-Nya/releases/<RELEASE_ID>/assets?name=caelestia-chinese-nyaV1.0.zip"
   ```

## GitHub Pages 文档站

本仓库同时托管文档站（分支 `gh-pages`）：

```
https://monika-miaomiao.github.io/caelestia-Chinese-Nya/
```

- `index.html`：简约深色风格、带侧边栏的文档站
- `list.txt`：项目目录清单（每行 `id|标题|图标`）
- `README/<id>.md`：每个项目的详细文档
