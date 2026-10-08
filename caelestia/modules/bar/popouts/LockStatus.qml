import QtQuick.Layouts
import Caelestia.Config
import Caelestia.I18n
import qs.components
import qs.services

ColumnLayout {
    spacing: Tokens.spacing.small

    StyledText {
        text: Hypr.capsLock ? Tr.tr("大写锁定已启用喵") : Tr.tr("大写锁定已关闭喵")
    }

    StyledText {
        text: Hypr.numLock ? Tr.tr("数字锁定已启用喵") : Tr.tr("数字锁定已关闭喵")
    }
}
