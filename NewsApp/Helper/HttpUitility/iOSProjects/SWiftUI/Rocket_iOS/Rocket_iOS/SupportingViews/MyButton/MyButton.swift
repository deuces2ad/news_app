//
//  MyButton.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 31/12/21.
//

import SwiftUI

struct MyButton: View {
    var body: some View {

        ZStack {
            AppThemeConfig.themeDarkBrown
            Button(action: {}) {
                    Text("Login")
                        .font(Font.custom(AppThemeConfig.AvenirFont, size: 14))
                        .padding()
                        .frame(maxWidth:.infinity)
                        
                }
            .contentShape(Rectangle())
            .background(AppThemeConfig.themeYellowColor)
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .padding()
        }
  
    }
}

struct MyButton_Previews: PreviewProvider {
    static var previews: some View {
        MyButton()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
