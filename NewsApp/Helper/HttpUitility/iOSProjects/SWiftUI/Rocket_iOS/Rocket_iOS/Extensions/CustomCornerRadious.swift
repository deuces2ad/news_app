//
//  CustomCornerRadious.swift
//  ECommerceAppSwiftUI
//
//  Created by Abhishek Dhiman on 13/12/21.
//  Copyright © 2021 Abhishek Dhiman. All rights reserved.
//

import Foundation
import SwiftUI

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
