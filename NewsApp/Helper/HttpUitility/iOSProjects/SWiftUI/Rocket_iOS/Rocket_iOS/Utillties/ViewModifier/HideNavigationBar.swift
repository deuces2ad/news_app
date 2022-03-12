//
//  HideNavigationBar.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 16/01/22.
//

import Foundation
import SwiftUI

struct HideNavigationBar : ViewModifier{
    func body(content: Content) -> some View {
        content
            .backport.topPadding(30) //for iOS 13 only
            .navigationBarTitle("") //this must be empty
             .navigationBarHidden(true)
             .navigationBarBackButtonHidden(true)
    }
}
