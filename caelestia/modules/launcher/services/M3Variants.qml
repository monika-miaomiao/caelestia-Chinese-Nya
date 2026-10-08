pragma Singleton

import ".."
import QtQuick
import Quickshell
import Caelestia.Config
import Caelestia.I18n
import qs.utils

Searcher {
    id: root

    function transformSearch(search: string): string {
        return search.slice(`${GlobalConfig.launcher.actionPrefix}variant `.length);
    }

    list: [
        Variant {
            variant: "vibrant"
            icon: "sentiment_very_dissatisfied"
            name: Tr.trCtx("Vibrant喵", "M3 scheme variant name")
            description: Tr.tr("高色度调色板，主调色板色度最高喵")
        },
        Variant {
            variant: "tonalspot"
            icon: "android"
            name: Tr.trCtx("Tonal Spot喵", "M3 scheme variant name")
            description: Tr.tr("Material 主题颜色的默认值，低色度的柔和调色板喵")
        },
        Variant {
            variant: "expressive"
            icon: "compare_arrows"
            name: Tr.trCtx("Expressive喵", "M3 scheme variant name")
            description: Tr.tr("中色度调色板，主调色板色相与种子色不同，以提供变化喵")
        },
        Variant {
            variant: "fidelity"
            icon: "compare"
            name: Tr.trCtx("Fidelity喵", "M3 scheme variant name")
            description: Tr.tr("与种子色一致，即使种子色很亮（高色度）喵")
        },
        Variant {
            variant: "content"
            icon: "sentiment_calm"
            name: Tr.trCtx("内容喵", "M3 scheme variant name")
            description: Tr.tr("与 Fidelity 几乎相同喵")
        },
        Variant {
            variant: "fruitsalad"
            icon: "nutrition"
            name: Tr.trCtx("Fruit Salad喵", "M3 scheme variant name")
            description: Tr.tr("活泼的主题——种子色的色相不会出现在主题中喵")
        },
        Variant {
            variant: "rainbow"
            icon: "looks"
            name: Tr.trCtx("彩虹喵", "M3 scheme variant name")
            description: Tr.tr("活泼的主题——种子色的色相不会出现在主题中喵")
        },
        Variant {
            variant: "neutral"
            icon: "contrast"
            name: Tr.trCtx("中性喵", "M3 scheme variant name")
            description: Tr.tr("接近灰度，略带色度喵")
        },
        Variant {
            variant: "monochrome"
            icon: "filter_b_and_w"
            name: Tr.trCtx("单色喵", "M3 scheme variant name")
            description: Tr.tr("所有颜色均为灰度，无色度喵")
        }
    ]
    useFuzzy: GlobalConfig.launcher.useFuzzy.variants

    component Variant: QtObject {
        required property string variant
        required property string icon
        required property string name
        required property string description

        function onClicked(list: AppList): void {
            list.screenState.launcher = false;
            Quickshell.execDetached(["caelestia", "scheme", "set", "-v", variant]);
        }
    }
}
