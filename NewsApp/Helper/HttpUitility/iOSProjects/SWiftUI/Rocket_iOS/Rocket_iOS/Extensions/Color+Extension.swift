//
//  Color+Extension.swift
//  HotelBookingApp
//
//  Created by Abhishek Dhiman on 13/12/21.
//  Copyright © 2021 Abhishek Dhiman. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    
    init(hex: String) {
        
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
}
