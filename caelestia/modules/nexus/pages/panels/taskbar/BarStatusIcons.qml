pragma ComponentBehavior: Bound

import QtQuick.Layouts
import Caelestia.Config
import Caelestia.I18n
import qs.modules.nexus.common

PageBase {
    id: root

    readonly property var builtinIcons: ({
            lockStatus: Tr.tr("锁定键喵"),
            kbLayout: Tr.tr("键盘布局喵"),
            audio: Tr.tr("扬声器喵"),
            microphone: Tr.tr("麦克风喵"),
            network: Tr.tr("网络喵"),
            bluetooth: Tr.tr("Bluetooth喵"),
            battery: Tr.tr("电池喵")
        })

    title: Tr.tr("状态图标喵")
    isSubPage: true

    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        width: root.cappedWidth
        spacing: Tokens.spacing.extraSmall / 2

        // Visible icons
        SectionHeader {
            first: true
            text: Tr.tr("可见图标喵")
        }

        ListEditor {
            function labelFor(item: var): string {
                const prettyName = root.builtinIcons[item.id];
                if (prettyName)
                    return prettyName;
                const label = item.id.replace(/([A-Z])/g, " $1");
                return label.charAt(0).toUpperCase() + label.slice(1).toLowerCase();
            }

            function toggledFor(item: var): bool {
                return item.enabled;
            }

            z: 1
            first: true
            values: Config.bar.statusIcons.values
            onItemMoved: (from, to) => GlobalConfig.bar.statusIcons.move(from, to)
            onItemRemoved: index => GlobalConfig.bar.statusIcons.remove(index)
            onItemToggled: (index, checked) => GlobalConfig.bar.statusIcons.at(index).enabled = checked
        }

        DialogSelectButton {
            id: addItemContainer

            rootParent: root.flickable
            icon: "add"
            label: Tr.tr("添加条目喵")
            header: Tr.tr("添加新条目喵")
            acceptLabel: Tr.trCtx("添加喵", "button")

            model: {
                const builtins = Object.keys(root.builtinIcons).map(k => ({
                            id: k,
                            label: root.builtinIcons[k]
                        }));
                return builtins;
            }

            onAccepted: {
                if (!selectedItem) // Should never happen but just in case
                    return;

                GlobalConfig.bar.statusIcons.insert({
                    id: selectedItem,
                    enabled: true
                });
            }
        }

        // Behaviour
        SectionHeader {
            text: Tr.tr("行为喵")
        }

        ToggleRow {
            first: true
            last: true
            text: Tr.tr("悬停时弹出喵")
            subtext: Tr.tr("悬停状态图标时显示详情弹窗喵")
            checked: Config.bar.popouts.statusIcons
            onToggled: GlobalConfig.bar.popouts.statusIcons = checked
        }
    }
}
