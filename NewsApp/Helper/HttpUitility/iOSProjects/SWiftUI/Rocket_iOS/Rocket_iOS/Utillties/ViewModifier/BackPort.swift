//
//  BackPort.swift
//  Rocket_iOS
//
//  Created by Apple on 13/01/22.
//

import Foundation
import SwiftUI

struct Backport<Content> {
    let content: Content
}

extension View {
    var backport: Backport<Self> { Backport(content: self) }
}

extension Backport where Content: View {
    @ViewBuilder func topPadding(_ top: CGFloat) -> some View {
        if #available(iOS 14, *) {
            content
        } else {
            content
                .padding([.top,],top)
        }
    }
}


