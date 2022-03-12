//
//  YelloButtonStyle.swift
//  Rocket_iOS
//
//  Created by Apple on 16/01/22.
//

import Foundation
import SwiftUI

struct CustomButtonStyle : ViewModifier{
    
    var forgroundColor : Color
    var textColor : Color = AppThemeConfig.themeLightBrownColor
    
    func body(content: Content) -> some View {
        content
//            .padding(.horizontal,25)
//            .padding(.vertical,10)
            .foregroundColor(textColor)
            .font(Font.custom(AppThemeConfig.AvenirFont, size: 16).weight(.semibold))
            .background(forgroundColor)
            .clipShape(Capsule())
    }
    
}
