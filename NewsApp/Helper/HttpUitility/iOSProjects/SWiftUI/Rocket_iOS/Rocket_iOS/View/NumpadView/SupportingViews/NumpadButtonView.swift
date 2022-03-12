//
//  NumpadButtonView.swift
//  Rocket_iOS
//
//  Created by Apple on 19/01/22.
//

import SwiftUI

struct NumpadButtonView : View {
    
    var numbpad : NumpadButton
    @EnvironmentObject var env : NumpadGlobalObject
    
    var body: some View{
        if numbpad.isSpecialCharacter{
            Button(action: {
                if numbpad == .delete{
                    if env.display.count > 1{
                        env.deleteOperation()
                    }
                    
                }
            }) {
                Image(numbpad.title)
                    .frame(width: buttonWidth(), height: buttonWidth())
                    .font(.custom(AppThemeConfig.AvenirFont, size: 32))
                    .foregroundColor(AppThemeConfig.themeLightBrownColor)
                    .background(AppThemeConfig.themeLightYellowColor)
                    .cornerRadius(buttonWidth())
                
            }
        }else{
            Button(action: {
                env.receiveInput(numpadButton: numbpad)
            }) {
                Text(numbpad.title)
                    .frame(width: buttonWidth(), height: buttonWidth())
                    .font(.custom(AppThemeConfig.AvenirFont, size: 32))
                    .foregroundColor(AppThemeConfig.themeLightBrownColor)
                    .background(AppThemeConfig.themeLightYellowColor)
                    .cornerRadius(buttonWidth())
            }
        }
        
    }
    func buttonWidth() -> CGFloat{
        return (getRect().width - 4 * 30) / 3.5
    }
}

struct NumpadButtonView_Previews: PreviewProvider {
    static var previews: some View {
        NumpadButtonView(numbpad: .one)
            .previewLayout(.sizeThatFits)
    }
}
