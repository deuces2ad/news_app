//
//  CompleteYourProfileBanner.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 28/12/21.
//

import SwiftUI

struct CompleteYourProfileBanner: View {
    
     // MARK: - PROPERTIES
    let TAG = "CompleteYourProfileBanner"
    
    var body: some View {
        
        VStack{
            Image("character")
            
            VStack(spacing: 0) {
                Text("Complete Profile")
                    .foregroundColor(AppThemeConfig.themeDarkBrown)
                    .font(Font.custom(AppThemeConfig.AvenirFont, size: 16))
                Text("Complete your data now to start investing!")
                    .foregroundColor(AppThemeConfig.themeDarkBrown)
                    .font(Font.custom(AppThemeConfig.AvenirFont, size: 14))
            }
            .padding()
            
            CustomButton(title: "Complete Profile", verticlePadding: 10, backgroundColor: AppThemeConfig.themeYellowColor) {
                //
                Log.echo(key: TAG, text: "complete profile button tapped")
            }
            .frame(width:getRect().width * 0.40)
        }
        .padding(.bottom,30)
    }
}

struct CompleteYourProfileBanner_Previews: PreviewProvider {
    static var previews: some View {
        CompleteYourProfileBanner()
            .previewLayout(.sizeThatFits)
    }
}
