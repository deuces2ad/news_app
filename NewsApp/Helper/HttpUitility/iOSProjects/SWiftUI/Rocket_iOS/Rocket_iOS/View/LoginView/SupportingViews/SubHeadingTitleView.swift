//
//  SubHeadingTitleView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 17/12/21.
//

import SwiftUI

struct SubHeadingTitleView: View {
    
    var title : LoginPageHeadingTitle
    
    var fontSize : CGFloat{
        return UIDevice.isIPad ? 29 : 21
    }
    
    var body: some View {
        
        HStack(alignment: .center) {
            Text(title.rawValue)
                .font(Font.custom(AppThemeConfig.AvenirFont, size: fontSize).bold())
               
           Spacer()
        }
            
        
    }
}

#if DEBUG
struct SubHeadingTitleView_Previews: PreviewProvider {
    static var previews: some View {
        SubHeadingTitleView(title:LoginPageHeadingTitle.Login)
    }
}
#endif
