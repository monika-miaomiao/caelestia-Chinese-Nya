pragma Singleton

import QtQuick
import Caelestia.I18n

QtObject {
    id: root

    readonly property list<var> pages: [
        // Appearance
        {
            label: Tr.tr("壁纸和样式喵"),
            icon: "palette",
            description: Tr.tr("壁纸、字体、颜色喵"),
            category: "appearance"
        },

        // Connectivity
        // TODO
        // {
        //     label: Tr.tr("显示喵"),
        //     icon: "monitor",
        //     description: Tr.tr("输出配置喵"),
        //     category: "connectivity"
        // },
        {
            label: Tr.tr("网络喵"),
            icon: "wifi",
            description: Tr.tr("Wi-Fi、以太网、VPN喵"),
            category: "connectivity"
        },
        {
            label: Tr.tr("已连接设备喵"),
            icon: "devices_other",
            description: Tr.tr("Bluetooth、配对喵"),
            category: "connectivity",
            noFill: true
        },
        {
            label: Tr.tr("音频喵"),
            icon: "volume_up",
            description: Tr.tr("应用音量、声音设备喵"),
            category: "connectivity"
        },

        // System
        {
            label: Tr.tr("更新喵"),
            icon: "update",
            description: Tr.tr("系统更新喵"),
            category: "system"
        },
        {
            label: Tr.tr("插件喵"),
            icon: "extension",
            description: Tr.tr("管理插件喵"),
            category: "system"
        },

        // Shell
        {
            label: Tr.tr("面板喵"),
            icon: "dock_to_bottom",
            description: Tr.tr("仪表盘、任务栏、启动器、侧栏喵"),
            category: "shell"
        },
        {
            label: Tr.tr("应用喵"),
            icon: "apps",
            description: Tr.tr("默认应用、收藏、隐藏应用喵"),
            category: "shell"
        },
        {
            label: Tr.tr("服务喵"),
            icon: "build",
            description: Tr.tr("轮询间隔、歌词后端喵"),
            category: "shell"
        },
        {
            label: Tr.tr("语言和地区喵"),
            icon: "globe",
            description: Tr.tr("UI 语言、天气位置、显示单位喵"),
            category: "shell"
        },

        // About
        {
            label: Tr.tr("关于本喵喵"),
            icon: "info",
            description: Tr.tr("系统信息、致谢喵"),
            category: "about"
        },
    ]
}
