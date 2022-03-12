//
//  WelcomeTwo.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 15/12/21.
//

import SwiftUI

struct InfoSlideTwo: View {
    
     // MARK: - BODY
    var body: some View {
        ZStack {
            AppThemeConfig.orangeColor
                .edgesIgnoringSafeArea([.top,.bottom])
            VStack{
                PlanetThreeImage()
                Spacer()
                PlanetFourImage()
                Spacer()
                InfoTextForSlideTwo()
                Spacer()
            }//:VSTACK
        }//:ZSTACK
    }
}

struct WelcomeTwo_Previews: PreviewProvider {
    static var previews: some View {
        
        Group{
            InfoSlideTwo()
                .previewDevice("iPhone 8")
            InfoSlideTwo()
                .previewDevice("iPhone 13")
            InfoSlideTwo()
                .previewDevice(DeviceList.iPadMini6ThGeneration)
        }
    }
}
