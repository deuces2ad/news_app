//
//  CarryOnBtnAction.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 16/12/21.
//

import SwiftUI

struct CarryOnBtnAction: View{
    var action: ()->Void
    var body: some View {
        Button(action: action) {
            Text("Cary On!")
                .padding()
                .padding(.horizontal,10)
                .font(Font.custom("Avenir", size: 18))
                .foregroundColor(.black)
                .background(AppThemeConfig.themeYellowColor)
                .clipShape(Capsule())
            
        }//:Button
        .offset(y:17)
    }
}


struct CarryOnBtnAction_Previews: PreviewProvider {
    static var previews: some View {
        CarryOnBtnAction(action: {})
    }
}
