pragma ComponentBehavior: Bound

import QtQuick
import Caelestia.Config
import Caelestia.I18n
import qs.components
import qs.services
import qs.modules.lock

Item {
    id: root

    required property Pam pam

    readonly property string msg: {
        // Errors
        if (pam.fprint.state === Pam.Error)
            return Tr.tr("指纹错误：%1喵").arg(pam.fprint.message);
        if (pam.howdy.state === Pam.Error)
            return Tr.tr("面部错误：%1喵").arg(pam.howdy.message);
        if (pam.state === Pam.Error)
            return Tr.tr("密码错误：%1喵").arg(pam.passwd.message);

        // Fprint/howdy fail
        if (pam.state !== Pam.MaxTries) {
            if (pam.fprint.state === Pam.Failed)
                // TRANSLATORS: %1 = attempts used so far, %2 = maximum attempts allowed
                return Tr.tr("指纹识别失败（%1/%2）。请重试或使用密码喵").arg(pam.fprint.tries).arg(GlobalConfig.lock.maxFprintTries);
            if (pam.howdy.state === Pam.Failed)
                // TRANSLATORS: %1 = attempts used so far, %2 = maximum attempts allowed
                return Tr.tr("人脸识别失败（%1/%2）。请重试或使用密码喵").arg(pam.howdy.tries).arg(GlobalConfig.lock.maxHowdyTries);
        } else {
            if (pam.fprint.state === Pam.Failed)
                // TRANSLATORS: %1 = attempts used so far, %2 = maximum attempts allowed
                return Tr.tr("指纹识别失败（%1/%2）。请重试喵").arg(pam.fprint.tries).arg(GlobalConfig.lock.maxFprintTries);
            if (pam.howdy.state === Pam.Failed)
                // TRANSLATORS: %1 = attempts used so far, %2 = maximum attempts allowed
                return Tr.tr("人脸识别失败（%1/%2）。请重试喵").arg(pam.howdy.tries).arg(GlobalConfig.lock.maxHowdyTries);
        }

        if (pam.lockMessage) // Password max tries message
            return pam.lockMessage;

        // Password fail
        if (pam.state === Pam.Failed) {
            if (pam.fprint.available && pam.fprint.state !== Pam.MaxTries)
                return Tr.tr("密码错误。请重试或使用指纹喵");
            if (pam.howdy.available && pam.howdy.state !== Pam.MaxTries)
                return Tr.tr("密码错误。请重试或使用人脸喵");
            return Tr.tr("密码错误。请重试喵");
        }

        // Maxed out
        if (pam.state === Pam.MaxTries) {
            if (pam.fprint.available && pam.fprint.state !== Pam.MaxTries)
                return Tr.tr("已达密码最大尝试次数。请使用指纹喵");
            if (pam.howdy.available && pam.howdy.state !== Pam.MaxTries)
                return Tr.tr("已达密码最大尝试次数。请使用人脸喵");
            if (pam.fprint.available || pam.howdy.available)
                return Tr.tr("所有认证方式均已达到最大尝试次数喵");
            return Tr.tr("已达密码最大尝试次数喵");
        }
        if (pam.fprint.state === Pam.MaxTries)
            return Tr.tr("已达指纹最大尝试次数。请使用密码喵");
        if (pam.howdy.state === Pam.MaxTries)
            return Tr.tr("已达人脸最大尝试次数。请使用密码喵");

        return "";
    }

    readonly property string stateMsg: {
        if (Hypr.kbLayout !== Hypr.defaultKbLayout) {
            if (Hypr.capsLock && Hypr.numLock)
                // TRANSLATORS: %1 = the active keyboard layout name, e.g. "English (US)"
                return Tr.tr("大写锁定和数字锁定已开启。\n键盘布局：%1喵").arg(Hypr.kbLayoutFull);
            if (Hypr.capsLock)
                // TRANSLATORS: %1 = the active keyboard layout name, e.g. "English (US)"
                return Tr.tr("大写锁定已开启。键盘布局：%1喵").arg(Hypr.kbLayoutFull);
            if (Hypr.numLock)
                // TRANSLATORS: %1 = the active keyboard layout name, e.g. "English (US)"
                return Tr.tr("数字锁定已开启。键盘布局：%1喵").arg(Hypr.kbLayoutFull);
            // TRANSLATORS: %1 = the active keyboard layout name, e.g. "English (US)"
            return Tr.tr("键盘布局：%1喵").arg(Hypr.kbLayoutFull);
        }

        if (Hypr.capsLock && Hypr.numLock)
            return Tr.tr("大写锁定和数字锁定已开启喵");
        if (Hypr.capsLock)
            return Tr.tr("大写锁定已开启喵");
        if (Hypr.numLock)
            return Tr.tr("数字锁定已开启喵");

        return "";
    }

    property bool stateMsgShouldBeVisible

    onMsgChanged: {
        if (msg) {
            if (message.opacity > 0) {
                message.animate = true;
                message.text = msg;
                message.animate = false;

                exitAnim.stop();
                if (message.scale < 1)
                    appearAnim.restart();
                else
                    flashAnim.restart();
            } else {
                message.text = msg;
                exitAnim.stop();
                appearAnim.restart();
            }
        } else {
            appearAnim.stop();
            flashAnim.stop();
            exitAnim.start();
        }
    }

    onStateMsgChanged: {
        if (stateMsg) {
            if (stateMessage.opacity > 0) {
                stateMessage.animate = true;
                stateMessage.text = stateMsg;
                stateMessage.animate = false;
            } else {
                stateMessage.text = stateMsg;
            }
            stateMsgShouldBeVisible = true;
        } else {
            stateMsgShouldBeVisible = false;
        }
    }

    implicitHeight: Math.max(message.implicitHeight, stateMessage.implicitHeight)

    Behavior on implicitHeight {
        Anim {}
    }

    StyledText {
        id: stateMessage

        anchors.left: parent.left
        anchors.right: parent.right

        scale: root.stateMsgShouldBeVisible && !root.msg ? 1 : 0.7
        opacity: root.stateMsgShouldBeVisible && !root.msg ? 1 : 0
        color: Colours.palette.m3onSurfaceVariant

        font: Tokens.font.body.small
        horizontalAlignment: Qt.AlignHCenter
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        lineHeight: 1.2

        Behavior on scale {
            Anim {}
        }

        Behavior on opacity {
            Anim {
                type: Anim.DefaultEffects
            }
        }
    }

    StyledText {
        id: message

        anchors.left: parent.left
        anchors.right: parent.right

        scale: 0.7
        opacity: 0
        color: Colours.palette.m3error

        font: Tokens.font.body.small
        horizontalAlignment: Qt.AlignHCenter
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere

        Connections {
            function onFlashMsg(): void {
                exitAnim.stop();
                if (message.scale < 1)
                    appearAnim.restart();
                else
                    flashAnim.restart();
            }

            target: root.pam
        }

        Anim {
            id: appearAnim

            type: Anim.DefaultEffects
            target: message
            properties: "scale,opacity"
            to: 1
            onFinished: flashAnim.restart()
        }

        SequentialAnimation {
            id: flashAnim

            loops: 2

            FlashAnim {
                to: 0.3
            }
            FlashAnim {
                to: 1
            }
        }

        ParallelAnimation {
            id: exitAnim

            Anim {
                target: message
                property: "scale"
                to: 0.7
                type: Anim.StandardLarge
            }
            Anim {
                target: message
                property: "opacity"
                to: 0
                type: Anim.StandardLarge
            }
        }
    }

    component FlashAnim: NumberAnimation {
        target: message
        property: "opacity"
        duration: Tokens.anim.durations.small
        easing.type: Easing.Linear
    }
}
