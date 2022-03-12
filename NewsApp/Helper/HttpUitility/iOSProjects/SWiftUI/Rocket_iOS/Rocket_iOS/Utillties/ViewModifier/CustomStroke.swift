//
//  CustomStroke.swift
//  Rocket_iOS
//
//  Created by Apple on 16/01/22.
//

import Foundation
import SwiftUI

struct CustomStroke : ViewModifier{

    var borderColor : Color
    var lineWidth : CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(borderColor,
                            lineWidth: lineWidth)
            )
    }
}
