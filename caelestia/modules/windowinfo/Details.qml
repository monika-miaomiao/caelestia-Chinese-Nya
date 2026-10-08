import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Caelestia.Config
import Caelestia.I18n
import qs.components
import qs.services

ColumnLayout {
    id: root

    required property HyprlandToplevel client

    anchors.fill: parent
    spacing: Tokens.spacing.small

    Label {
        Layout.topMargin: Tokens.padding.extraLargeIncreased

        text: root.client?.title ?? Tr.tr("没有活动客户端喵")
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere

        font: Tokens.font.body.builders.large.weight(Font.Medium).build()
    }

    Label {
        text: root.client?.lastIpcObject.class ?? Tr.tr("没有活动客户端喵")
        color: Colours.palette.m3tertiary

        font: Tokens.font.body.large
    }

    StyledRect {
        Layout.fillWidth: true
        Layout.preferredHeight: 1
        Layout.leftMargin: Tokens.padding.extraLargeIncreased
        Layout.rightMargin: Tokens.padding.extraLargeIncreased
        Layout.topMargin: Tokens.spacing.medium
        Layout.bottomMargin: Tokens.spacing.largeIncreased

        color: Colours.palette.m3secondary
    }

    Detail {
        icon: "location_on"
        text: {
            const addr = root.client?.address;
            if (addr)
                return Tr.trCtx("地址：%1喵", "window address").arg(`0x${addr}`);
            return Tr.trCtx("地址：未知喵", "window address");
        }
        color: Colours.palette.m3primary
    }

    Detail {
        icon: "location_searching"
        // TRANSLATORS: %1/%2 = x and y position in pixels
        text: Tr.tr("位置：%1, %2喵").arg(root.client?.lastIpcObject.at[0] ?? -1).arg(root.client?.lastIpcObject.at[1] ?? -1)
    }

    Detail {
        icon: "resize"
        // TRANSLATORS: %1/%2 = width and height in pixels; the x is a multiplication sign
        text: Tr.tr("大小：%1 x %2喵").arg(root.client?.lastIpcObject.size[0] ?? -1).arg(root.client?.lastIpcObject.size[1] ?? -1)
        color: Colours.palette.m3tertiary
    }

    Detail {
        icon: "workspaces"
        // TRANSLATORS: %1 = workspace name, %2 = workspace id
        text: Tr.tr("工作区：%1（%2）喵").arg(root.client?.workspace.name ?? -1).arg(root.client?.workspace.id ?? -1)
        color: Colours.palette.m3secondary
    }

    Detail {
        icon: "desktop_windows"
        text: {
            const mon = root.client?.monitor;
            if (mon)
                // TRANSLATORS: %1 = monitor name, %2 = monitor id, %3/%4 = x/y position in pixels
                return Tr.tr("显示器：%1（%2）位置 %3, %4 喵").arg(mon.name).arg(mon.id).arg(mon.x).arg(mon.y);
            return Tr.tr("显示器：未知喵");
        }
    }

    Detail {
        icon: "page_header"
        text: {
            const title = root.client?.lastIpcObject.initialTitle;
            if (title)
                return Tr.tr("初始标题：%1喵").arg(title);
            return Tr.tr("初始标题：未知喵");
        }
        color: Colours.palette.m3tertiary
    }

    Detail {
        icon: "category"
        text: {
            const cls = root.client?.lastIpcObject.initialClass;
            if (cls)
                return Tr.tr("初始类：%1喵").arg(cls);
            return Tr.tr("初始类：未知喵");
        }
    }

    Detail {
        icon: "account_tree"
        // TRANSLATORS: %1 = process id
        text: Tr.tr("进程 ID：%1喵").arg(String(root.client?.lastIpcObject.pid ?? -1))
        color: Colours.palette.m3primary
    }

    Detail {
        icon: "picture_in_picture_center"
        text: root.client?.lastIpcObject.floating ? Tr.tr("浮动：是喵") : Tr.tr("浮动：否喵")
        color: Colours.palette.m3secondary
    }

    Detail {
        icon: "gradient"
        text: root.client?.lastIpcObject.xwayland ? Tr.tr("Xwayland：是喵") : Tr.tr("Xwayland：否喵")
    }

    Detail {
        icon: "keep"
        text: root.client?.lastIpcObject.pinned ? Tr.tr("固定：是喵") : Tr.tr("固定：否喵")
        color: Colours.palette.m3secondary
    }

    Detail {
        icon: "fullscreen"
        text: {
            const fs = root.client?.lastIpcObject.fullscreen;
            if (fs === 0)
                return Tr.tr("全屏状态：关闭喵");
            if (fs === 1)
                return Tr.tr("全屏状态：最大化喵");
            if (fs !== undefined)
                return Tr.tr("全屏状态：开启喵");
            return Tr.tr("全屏状态：未知喵");
        }
        color: Colours.palette.m3tertiary
    }

    Item {
        Layout.fillHeight: true
    }

    component Detail: RowLayout {
        id: detail

        required property string icon
        required property string text
        property alias color: icon.color

        Layout.leftMargin: Tokens.padding.large
        Layout.rightMargin: Tokens.padding.large
        Layout.fillWidth: true

        spacing: Tokens.spacing.medium

        MaterialIcon {
            id: icon

            Layout.alignment: Qt.AlignVCenter
            text: detail.icon
        }

        StyledText {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter

            text: detail.text
            elide: Text.ElideRight
            font: Tokens.font.body.medium
        }
    }

    component Label: StyledText {
        Layout.leftMargin: Tokens.padding.large
        Layout.rightMargin: Tokens.padding.large
        Layout.fillWidth: true
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignHCenter
        animate: true
    }
}
