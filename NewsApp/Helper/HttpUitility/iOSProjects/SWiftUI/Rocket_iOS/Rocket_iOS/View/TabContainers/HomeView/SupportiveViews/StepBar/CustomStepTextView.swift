//
//  CustomStepTextView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 30/12/21.
//

import SwiftUI

struct CustomStepTextView: View {
    
    var text:String
    
    var timeInfo : String
    
    
    
    var body: some View {
        HStack {
            TextView(text: text, font: Font.system(size: 16, weight: Font.Weight.regular))
                .foregroundColor(AppThemeConfig.themeLightBrownColor)
                .font(Font.custom(AppThemeConfig.AvenirFont, size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Text(timeInfo)
                .foregroundColor(AppThemeConfig.orangeColor)
                .font(Font.custom(AppThemeConfig.AvenirFont, size: 14).weight(.medium))
            
        }
//        .background(Color.red)
    }
}
struct CustomStepTextView_Previews: PreviewProvider {
    static var previews: some View {
        CustomStepTextView(text: "Lengkapi Profil", timeInfo: "1 hari kerja")
    }
}
