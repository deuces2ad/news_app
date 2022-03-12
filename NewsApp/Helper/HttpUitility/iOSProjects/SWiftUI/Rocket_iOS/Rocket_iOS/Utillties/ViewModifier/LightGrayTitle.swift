//
//  LightGrayTitle.swift
//  Rocket_iOS
//
//  Created by Apple on 05/01/22.
//

import SwiftUI

struct LightGrayTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom(AppThemeConfig.AvenirFont, size: 14))
            .foregroundColor(AppThemeConfig.themeGrayColor)
    }
}
