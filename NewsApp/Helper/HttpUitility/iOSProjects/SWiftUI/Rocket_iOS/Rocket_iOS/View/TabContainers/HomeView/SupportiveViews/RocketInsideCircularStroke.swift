//
//  RocketInsideCircularStroke.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 23/12/21.
//

import SwiftUI

struct RocketInsideCircularStroke: View {
    var body: some View {
        VStack {
            Circle()
                .strokeBorder(Color.init(hex: "824529"),lineWidth: 2)
                .frame(width: 30, height: 30)
                .background(
                    ZStack{
                        Image("logo")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 20)
                            .foregroundColor(AppThemeConfig.themeLightBrownColor)
                            .zIndex(1)
                        Circle()
                            .foregroundColor(AppThemeConfig.themeLightYellowColor)
                    }
                )
        }
    }
}

struct RocketInsideCircularStroke_Previews: PreviewProvider {
    static var previews: some View {
        RocketInsideCircularStroke()
            .previewLayout(.sizeThatFits)
    }
}
