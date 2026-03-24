package com.example.moodexample.unimp.config

import io.dcloud.feature.sdk.DCSDKInitConfig
import io.dcloud.feature.sdk.MenuActionSheetItem

// 统一管理 UniMP 初始化配置
object UniMpConfigFactory {
    fun create(): DCSDKInitConfig {
        val sheetItems = mutableListOf(
            MenuActionSheetItem(MENU_TITLE_ABOUT, MENU_ID_ABOUT),
        )

        // 集中定义胶囊样式和默认菜单项
        return DCSDKInitConfig.Builder()
            .setCapsule(true)
            .setMenuDefFontSize("16px")
            .setMenuDefFontColor("#2D2D2D")
            .setMenuDefFontWeight("normal")
            .setMenuActionSheetItems(sheetItems)
            .build()
    }

    private const val MENU_TITLE_ABOUT = "关于"
    private const val MENU_ID_ABOUT = "about"
}
