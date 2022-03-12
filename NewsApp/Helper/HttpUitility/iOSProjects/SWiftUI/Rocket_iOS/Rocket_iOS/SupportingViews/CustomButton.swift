//
//  LoginAndSignUpContainer.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 17/12/21.
//

import SwiftUI


struct CustomButton: View {
    
     // MARK: - Properties
    
    var title : String
    var verticlePadding : CGFloat
    var backgroundColor : Color
    
    
    var action : ()->Void
   
    
    private var fontSize : CGFloat{
        return UIDevice.isIPad ? 24 : 16
    }
   
 // MARK: - Body
    var body: some View {
        HStack {
            Button(action: action) {
                Text(title)
                    .font(Font.custom(AppThemeConfig.AvenirFont, size: fontSize))
                    .foregroundColor(.black)
                    .padding(.vertical,verticlePadding)
                    .accentColor(Color(.systemRed))
                    .fixedSize()
                    .frame(maxWidth:.infinity)
                    .background(backgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(AppThemeConfig.themeYellowColor, lineWidth: 2)
                )
                    .cornerRadius(40)
            }
            .contentShape(Rectangle())
            .background(backgroundColor) // If you have this
                .cornerRadius(25)
           
        }
       
    }
}

