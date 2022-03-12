//
//  NextPageAction.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 16/12/21.
//

import SwiftUI

struct NextPageAction: View {
    var action: ()->Void
    var body: some View {
        Button(action: action) {
           Image(systemName: "arrow.right")
                .font(.headline)
                .padding()
                .foregroundColor(.black)
                .background(AppThemeConfig.themeYellowColor)
                .clipShape(Circle())
            
        }//:Button
        .offset(y:17)
    }
}

struct NextPageAction_Previews: PreviewProvider {
    static var previews: some View {
        NextPageAction(action: {})
    }
}
