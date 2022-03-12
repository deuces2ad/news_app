//
//  RectangularFrame.swift
//  Rocket_iOS
//
//  Created by Apple on 05/01/22.
//

import SwiftUI

struct RectangularFrame : ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .stroke(AppThemeConfig.LightGray, lineWidth: 1)
                
            )
    }
}
