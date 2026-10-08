#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
caelestia-Chinese-Nya TUI
萌猫语 Caelestia Shell 配置 · 图形终端安装器

无需任何第三方依赖，Python 3 + curses 即可运行：
    python3 tui.py
"""

import curses
import os
import shutil
import subprocess
import tempfile
import urllib.request

REPO = "monika-miaomiao/caelestia-Chinese-Nya"
RAW = f"https://raw.githubusercontent.com/{REPO}/main"
DEST_DIR = os.path.expanduser("~/.config/quickshell")
DEST = os.path.join(DEST_DIR, "caelestia")

LOGO = r"""
  ╔══════════════════════════════════════════╗
  ║   /\_/\   Caelestia · Chinese Nya        ║
  ║  ( o.o )  萌猫语配置安装器 v1.0          ║
  ║   > ^ <    本喵为你服务喵～              ║
  ╚══════════════════════════════════════════╝
"""

MENU = [
    ("📦  安装萌猫语配置", "install"),
    ("🗑️  卸载 / 回退到官方版", "uninstall"),
    ("⚡  快速恢复 / 重装（联网）", "reinstall"),
    ("🔍  查看当前状态", "status"),
    ("🚪  退出", "quit"),
]


def run(cmd, stdin=None):
    return subprocess.run(
        cmd, shell=True, stdin=stdin,
        stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True,
    ).stdout


def detect():
    """返回 (已安装, 备份数量, qs是否存在)"""
    installed = os.path.isfile(os.path.join(DEST, "shell.qml"))
    backups = [b for b in os.listdir(DEST_DIR) if b.startswith("caelestia.bak.")] if os.path.isdir(DEST_DIR) else []
    has_qs = shutil.which("qs") is not None
    return installed, backups, has_qs


def draw_box(stdscr, y, x, h, w, title, color):
    stdscr.attron(curses.color_pair(color))
    stdscr.addstr(y, x, "┌" + "─" * (w - 2) + "┐")
    if title:
        t = f" {title} "
        stdscr.addstr(y, x + 2, t)
    for i in range(1, h - 1):
        stdscr.addstr(y + i, x, "│")
        stdscr.addstr(y + i, x + w - 1, "│")
    stdscr.addstr(y + h - 1, x, "└" + "─" * (w - 2) + "┘")
    stdscr.attroff(curses.color_pair(color))


def center(stdscr, y, text, color):
    h, w = stdscr.getmaxyx()
    x = max(0, (w - len(text)) // 2)
    stdscr.attron(curses.color_pair(color))
    stdscr.addstr(y, x, text[: w - x - 1])
    stdscr.attroff(curses.color_pair(color))


def confirm(stdscr, prompt):
    while True:
        stdscr.clear()
        center(stdscr, 6, "⚠  确认操作", 3)
        center(stdscr, 8, prompt, 0)
        center(stdscr, 10, "[Y] 确认    [N] 取消", 2)
        stdscr.refresh()
        k = stdscr.getch()
        if k in (ord("y"), ord("Y")):
            return True
        if k in (ord("n"), ord("N"), 27):
            return False


def show_output(stdscr, title, output):
    lines = output.rstrip("\n").splitlines()
    stdscr.clear()
    center(stdscr, 1, f"🐾 {title}", 1)
    h, w = stdscr.getmaxyx()
    box_h = min(len(lines) + 2, h - 6)
    draw_box(stdscr, 3, 2, box_h, w - 4, title, 4)
    for i, line in enumerate(lines[: box_h - 2]):
        stdscr.addstr(4 + i, 4, line[: w - 8])
    center(stdscr, h - 2, "按任意键返回…", 2)
    stdscr.refresh()
    stdscr.getch()


def do_install(stdscr, src):
    script = os.path.join(src, "install.sh") if src else None
    if script and os.path.isfile(script):
        out = run(f"bash '{script}'")
    else:
        out = run("bash ~/caelestia-chinese-nya.sh")
    show_output(stdscr, "安装日志", out or "（无输出）")


def do_reinstall(stdscr):
    script = os.path.expanduser("~/caelestia-chinese-nya.sh")
    if os.path.isfile(script):
        out = run(f"bash '{script}'")
    else:
        with tempfile.TemporaryDirectory() as td:
            out = run(f"git clone --depth 1 https://github.com/{REPO}.git '{td}/repo' && bash '{td}/repo/install.sh'")
    show_output(stdscr, "快速恢复日志", out or "（无输出）")


def do_uninstall(stdscr):
    out = run(f"rm -rf '{DEST}'")
    show_output(stdscr, "卸载完成", "已删除萌猫语配置喵～\n\n重启 shell 即可恢复官方版：\n  qs -c caelestia kill; caelestia shell -d")


def do_status(stdscr):
    installed, backups, has_qs = detect()
    lines = [
        f"配置目录      : {DEST}",
        f"安装状态      : {'✅ 已安装（萌猫语）' if installed else '⬜ 未安装'}",
        f"Quickshell qs : {'✅ 已找到' if has_qs else '❌ 未找到'}",
        f"历史备份数量  : {len(backups)} 个",
    ]
    for b in sorted(backups, reverse=True)[:5]:
        lines.append(f"  · {b}")
    lines += [
        "",
        "本机脚本      : ~/caelestia-chinese-nya.sh"
        + (" ✅" if os.path.isfile(os.path.expanduser("~/caelestia-chinese-nya.sh")) else " ⬜（未安装）"),
        "交流 QQ 群    : 1126854380",
        "B站           : https://b23.tv/AdaW44h",
        "邮箱          : xiaoran_official@hotmail.com",
    ]
    show_output(stdscr, "当前状态", "\n".join(lines))


def main(stdscr):
    curses.curs_set(0)
    curses.init_pair(1, curses.COLOR_CYAN, curses.COLOR_BLACK)
    curses.init_pair(2, curses.COLOR_GREEN, curses.COLOR_BLACK)
    curses.init_pair(3, curses.COLOR_YELLOW, curses.COLOR_BLACK)
    curses.init_pair(4, curses.COLOR_MAGENTA, curses.COLOR_BLACK)
    curses.init_pair(5, curses.COLOR_WHITE, curses.COLOR_BLACK)
    curses.init_pair(6, curses.COLOR_RED, curses.COLOR_BLACK)

    sel = 0
    src = os.path.dirname(os.path.abspath(__file__))

    while True:
        stdscr.clear()
        h, w = stdscr.getmaxyx()
        installed, backups, has_qs = detect()

        for i, line in enumerate(LOGO.strip("\n").splitlines()):
            center(stdscr, 1 + i, line, 4)

        center(stdscr, 7, "─" * min(44, w - 6), 5)
        for i, (label, _) in enumerate(MENU):
            mark = "▶" if i == sel else " "
            style = curses.A_REVERSE if i == sel else curses.A_NORMAL
            txt = f"  {mark} {label}"
            x = max(0, (w - len(txt)) // 2)
            stdscr.attron(curses.color_pair(1 if i == sel else 5) | style)
            stdscr.addstr(9 + i * 2, x, txt)
            stdscr.attroff(curses.color_pair(1 if i == sel else 5) | style)

        status = (
            f"  状态: {'✅ 已安装' if installed else '⬜ 未安装'}   备份: {len(backups)} 个   qs: {'✅' if has_qs else '❌'}  "
        )
        center(stdscr, 9 + len(MENU) * 2 + 1, status, 2)
        center(stdscr, h - 2, "↑↓ 选择 · Enter 确认 · q 退出", 3)
        stdscr.refresh()

        k = stdscr.getch()
        if k == curses.KEY_UP and sel > 0:
            sel -= 1
        elif k == curses.KEY_DOWN and sel < len(MENU) - 1:
            sel += 1
        elif k in (ord("q"), ord("Q")):
            break
        elif k in (curses.KEY_ENTER, 10, 13):
            action = MENU[sel][1]
            if action == "quit":
                break
            if action == "install":
                if confirm(stdscr, "安装萌猫语配置？旧配置将自动备份。"):
                    do_install(stdscr, src)
            elif action == "uninstall":
                if confirm(stdscr, "卸载并删除萌猫语配置？（可通过备份恢复）"):
                    do_uninstall(stdscr)
            elif action == "reinstall":
                if confirm(stdscr, "从 GitHub 拉取最新版并重装？"):
                    do_reinstall(stdscr)
            elif action == "status":
                do_status(stdscr)


if __name__ == "__main__":
    try:
        curses.wrapper(main)
    except KeyboardInterrupt:
        pass
