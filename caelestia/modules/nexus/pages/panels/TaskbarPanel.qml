pragma ComponentBehavior: Bound

import QtQuick.Layouts
import Caelestia.Config
import Caelestia.I18n
import qs.modules.nexus.common

PageBase {
    id: root

    title: Tr.tr("任务栏喵")
    isSubPage: true

    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        width: root.cappedWidth
        spacing: Tokens.spacing.extraSmall / 2

        // Behaviour
        SectionHeader {
            first: true
            text: Tr.tr("行为喵")
        }

        ToggleRow {
            first: true
            text: Tr.tr("持久喵")
            subtext: Tr.tr("始终保持栏可见喵")
            checked: Config.bar.persistent
            onToggled: GlobalConfig.bar.persistent = checked
        }

        ToggleRow {
            text: Tr.tr("悬停时显示喵")
            subtext: Tr.tr("光标到达屏幕边缘时显示栏喵")
            checked: Config.bar.showOnHover
            onToggled: GlobalConfig.bar.showOnHover = checked
        }

        StepperRow {
            last: true
            label: Tr.tr("拖动阈值喵")
            subtext: Tr.tr("栏显示前需拖动的像素数喵")
            value: Config.bar.dragThreshold
            from: 0
            to: 200
            stepSize: 5
            onMoved: v => GlobalConfig.bar.dragThreshold = v
        }

        // Components
        SectionHeader {
            text: Tr.tr("组件喵")
        }

        NavRow {
            first: true
            icon: "workspaces"
            text: Tr.tr("工作区喵")
            subtext: Tr.tr("指示器、窗口图标喵")
            onClicked: root.nState.openSubPage(6)
        }

        NavRow {
            icon: "web_asset"
            text: Tr.tr("当前窗口喵")
            subtext: Tr.tr("标题显示、弹窗喵")
            onClicked: root.nState.openSubPage(7)
        }

        NavRow {
            icon: "widgets"
            text: Tr.tr("托盘喵")
            subtext: Tr.tr("系统托盘图标喵")
            onClicked: root.nState.openSubPage(8)
        }

        NavRow {
            icon: "signal_cellular_alt"
            text: Tr.tr("状态图标喵")
            subtext: Tr.tr("可见指示器喵")
            onClicked: root.nState.openSubPage(9)
        }

        NavRow {
            last: true
            icon: "schedule"
            text: Tr.tr("时钟喵")
            subtext: Tr.tr("日期、图标、背景喵")
            onClicked: root.nState.openSubPage(10)
        }

        // Scroll actions
        SectionHeader {
            text: Tr.tr("滚动操作喵")
        }

        ToggleRow {
            first: true
            text: Tr.tr("工作区喵")
            subtext: Tr.tr("在工作区指示器上滚动以切换工作区喵")
            checked: Config.bar.scrollActions.workspaces
            onToggled: GlobalConfig.bar.scrollActions.workspaces = checked
        }

        ToggleRow {
            text: Tr.tr("音量喵")
            subtext: Tr.tr("在栏上半部分滚动以调节音量喵")
            checked: Config.bar.scrollActions.volume
            onToggled: GlobalConfig.bar.scrollActions.volume = checked
        }

        ToggleRow {
            last: true
            text: Tr.tr("亮度喵")
            subtext: Tr.tr("在栏下半部分滚动以调节亮度喵")
            checked: Config.bar.scrollActions.brightness
            onToggled: GlobalConfig.bar.scrollActions.brightness = checked
        }
    }
}
