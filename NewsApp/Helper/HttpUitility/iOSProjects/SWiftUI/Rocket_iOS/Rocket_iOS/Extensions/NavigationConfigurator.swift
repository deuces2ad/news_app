//
//  NavigationConfigurator.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 18/12/21.
//

import Foundation
import SwiftUI

extension View {
    
    func embedInNavigationView() -> some View{
        NavigationView { self }
    }
}
