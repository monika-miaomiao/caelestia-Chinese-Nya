import QtQuick.Layouts
import Caelestia.Config
import Caelestia.I18n
import qs.modules.nexus.common

PageBase {
    id: root

    title: Tr.tr("面板喵")

    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        width: root.cappedWidth
        spacing: Tokens.spacing.extraSmall / 2

        NavRow {
            first: true
            icon: "dashboard"
            text: Tr.tr("仪表盘喵")
            subtext: Config.dashboard.enabled ? Tr.trCtx("已启用喵", "panel status") : Tr.trCtx("已禁用喵", "panel status")
            onClicked: root.nState.openSubPage(1)
        }

        NavRow {
            icon: "dock_to_bottom"
            text: Tr.tr("任务栏喵")
            subtext: Config.bar.persistent ? Tr.tr("始终可见喵") : Config.bar.showOnHover ? Tr.tr("悬停时显示喵") : Tr.tr("拖动时显示喵")
            onClicked: root.nState.openSubPage(2)
        }

        NavRow {
            icon: "apps"
            text: Tr.tr("启动器喵")
            subtext: Config.launcher.enabled ? Tr.trCtx("已启用喵", "panel status") : Tr.trCtx("已禁用喵", "panel status")
            onClicked: root.nState.openSubPage(3)
        }

        NavRow {
            icon: "dock_to_right"
            text: Tr.tr("侧栏喵")
            subtext: Config.sidebar.enabled ? Tr.trCtx("已启用喵", "panel status") : Tr.trCtx("已禁用喵", "panel status")
            onClicked: root.nState.openSubPage(4)
        }

        NavRow {
            last: true
            icon: "construction"
            text: Tr.tr("实用工具喵")
            subtext: Config.utilities.enabled ? Tr.trCtx("已启用喵", "panel status") : Tr.trCtx("已禁用喵", "panel status")
            onClicked: root.nState.openSubPage(5)
        }
    }
}
