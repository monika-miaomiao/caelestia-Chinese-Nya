import QtQuick
import QtQuick.Layouts
import Quickshell
import Caelestia.Config
import Caelestia.I18n
import Caelestia.Services
import qs.components.controls
import qs.services
import qs.modules.nexus.common

PageBase {
    id: root

    // Lyrics backends, ordered to match config::LyricsBackend (Auto, Local, LRCLIB, NetEase)
    readonly property list<MenuItem> lyricsItems: [
        MenuItem {
            text: Tr.trCtx("自动喵", "lyrics backend")
        },
        MenuItem {
            text: Tr.trCtx("本地喵", "lyrics backend")
        },
        MenuItem {
            text: "LRCLIB"
        },
        MenuItem {
            text: "NetEase"
        }
    ]

    // GPU types, ordered to match config::GpuType (Auto, Nvidia, Generic, None)
    readonly property list<MenuItem> gpuItems: [
        MenuItem {
            text: Tr.trCtx("自动喵", "gpu type")
        },
        MenuItem {
            text: "NVIDIA"
        },
        MenuItem {
            text: Tr.trCtx("通用喵", "gpu type")
        },
        MenuItem {
            text: Tr.trCtx("无喵", "gpu type")
        }
    ]

    title: Tr.tr("服务喵")

    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        width: root.cappedWidth
        spacing: Tokens.spacing.extraSmall / 2

        // Detected running players, used as default-player options
        Variants {
            id: playerVariants

            model: [...new Set(Players.list.map(p => Players.getIdentity(p)).filter(id => id))]

            MenuItem {
                required property string modelData

                text: modelData
                icon: modelData === GlobalConfig.services.defaultPlayer ? "check" : ""
                activeIcon: "music_note"
            }
        }

        // Notifications
        SectionHeader {
            first: true
            text: Tr.tr("通知喵")
        }

        NavRow {
            first: true
            last: true
            icon: "notifications"
            text: Tr.tr("通知喵")
            subtext: Tr.tr("通知、Toast、超时喵")
            onClicked: root.nState.openSubPage(1)
        }

        // Polling
        SectionHeader {
            text: Tr.tr("轮询喵")
        }

        StepperRow {
            first: true
            label: Tr.tr("媒体刷新喵")
            // TRANSLATORS: ms is the millisecond unit, leave it untranslated
            subtext: Tr.tr("媒体进度更新频率（毫秒）喵")
            value: GlobalConfig.dashboard.mediaUpdateInterval
            from: 100
            to: 2000
            stepSize: 50
            onMoved: v => GlobalConfig.dashboard.mediaUpdateInterval = v
        }

        StepperRow {
            label: Tr.tr("系统状态刷新喵")
            // TRANSLATORS: CPU and GPU are hardware abbreviations, leave them untranslated
            subtext: Tr.tr("CPU、内存和 GPU 更新间隔（秒）喵")
            value: GlobalConfig.dashboard.resourceUpdateInterval / 1000
            from: 0.5
            to: 10
            stepSize: 0.5
            onMoved: v => GlobalConfig.dashboard.resourceUpdateInterval = Math.round(v * 1000)
        }

        StepperRow {
            last: true
            label: Tr.tr("Wi-Fi 重新扫描喵")
            subtext: Tr.tr("可用网络重新扫描的频率（秒）喵")
            value: GlobalConfig.nexus.networkRescanInterval / 1000
            from: 5
            to: 120
            stepSize: 5
            onMoved: v => GlobalConfig.nexus.networkRescanInterval = Math.round(v * 1000)
        }

        // Media & lyrics
        SectionHeader {
            text: Tr.tr("媒体和歌词喵")
        }

        SelectRow {
            first: true
            label: Tr.tr("歌词后端喵")
            subtext: Tr.tr("获取同步歌词的来源喵")
            menuItems: root.lyricsItems
            active: root.lyricsItems[Lyrics.preferredBackend] ?? root.lyricsItems[0]
            onSelected: item => Lyrics.preferredBackend = root.lyricsItems.indexOf(item)
        }

        SelectRow {
            last: true
            label: Tr.tr("默认播放器喵")
            subtext: Tr.tr("打开多个播放器时的首选媒体播放器喵")
            menuItems: playerVariants.instances
            active: menuItems.find(i => i.text === GlobalConfig.services.defaultPlayer) ?? null
            fallbackIcon: "music_note"
            fallbackText: GlobalConfig.services.defaultPlayer || Tr.trCtx("自动喵", "default media player")
            onSelected: item => GlobalConfig.services.defaultPlayer = item.text
        }

        // Input increments
        SectionHeader {
            text: Tr.tr("输入步进喵")
        }

        StepperRow {
            first: true
            label: Tr.tr("音量步长喵")
            subtext: Tr.tr("每次滚动音量变化量（%）喵")
            value: Math.round(GlobalConfig.services.audioIncrement * 100)
            from: 1
            to: 50
            stepSize: 1
            onMoved: v => GlobalConfig.services.audioIncrement = v / 100
        }

        StepperRow {
            label: Tr.tr("亮度步长喵")
            subtext: Tr.tr("每次滚动亮度变化量（%）喵")
            value: Math.round(GlobalConfig.services.brightnessIncrement * 100)
            from: 1
            to: 50
            stepSize: 1
            onMoved: v => GlobalConfig.services.brightnessIncrement = v / 100
        }

        StepperRow {
            last: true
            label: Tr.tr("最大音量喵")
            subtext: Tr.tr("输出音量上限（%）喵")
            value: Math.round(GlobalConfig.services.maxVolume * 100)
            from: 50
            to: 200
            stepSize: 5
            onMoved: v => GlobalConfig.services.maxVolume = v / 100
        }

        // Service tuning
        SectionHeader {
            text: Tr.tr("服务调优喵")
        }

        StepperRow {
            first: true
            // TRANSLATORS: bars of a spectrum analyser, not the taskbar
            label: Tr.tr("可视化条喵")
            subtext: Tr.tr("音频可视化条数量喵")
            value: GlobalConfig.services.visualiserBars
            from: 10
            to: 120
            stepSize: 2
            onMoved: v => GlobalConfig.services.visualiserBars = v
        }

        ToggleRow {
            text: Tr.tr("智能配色喵")
            subtext: Tr.tr("从壁纸推导主题模式与变体喵")
            checked: GlobalConfig.services.smartScheme
            onToggled: GlobalConfig.services.smartScheme = checked
        }

        SelectRow {
            last: true
            label: Tr.tr("GPU喵")
            subtext: Gpu.name ? Tr.tr("监视：%1喵").arg(Gpu.name) : Tr.tr("GPU 类型覆盖喵")
            menuOnTop: true
            menuItems: root.gpuItems
            active: root.gpuItems[GlobalConfig.services.gpuType]
            onSelected: item => GlobalConfig.services.gpuType = root.gpuItems.indexOf(item)
        }
    }
}
