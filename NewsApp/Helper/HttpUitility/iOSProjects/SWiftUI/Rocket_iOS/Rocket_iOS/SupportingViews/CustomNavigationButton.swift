//
//  ListNavigationView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 18/12/21.
//

import SwiftUI

struct CustomNavigationButton<Content:View>: View {
    
     // MARK: - PROPERTIES
    typealias Action = () -> ()
    
    var title : String
    var content :Content?
    var isNavigationRequired : Bool = false
    
    init(title : String , @ViewBuilder content : () -> Content? , isNavigationRequired: Bool , action: @escaping Action){
        self.title = title
        self.content = content()
        self.isNavigationRequired = isNavigationRequired
        self.action = action
    }
  
    var action : Action?
    
    var body: some View {
        
        if (isNavigationRequired == false){
            Button(action: action ?? {}) {
                CustomButtonLabel(withTitle: title)
            }
        }else{
            NavigationLink(destination: content) {
                CustomButtonLabel(withTitle: title)
            }.buttonStyle(.automatic)
        }
    }
}



private struct CustomButtonLabel : View {
    
    var withTitle : String
    var body :some View{
        Text(withTitle)
            .font(Font.custom(AppThemeConfig.AvenirFont, size: 18))
            .foregroundColor(AppThemeConfig.orangeColor)
    }
}
