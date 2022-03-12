//
//  WelcomeThree.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 15/12/21.
//

import SwiftUI

struct InfoSlideThree: View {
    
    var planetFiveBottom :CGFloat{
        return UIDevice.isIPad ? 0 : -35
    }
    
    var InfoTextForSlideBottom :CGFloat{
        return UIDevice.isIPad ? -160 : -135
    }
    
     // MARK: - BODY
    var body: some View {
        ZStack{
            VStack{
                PlanetSevenImage()
                PlanetFiveImage()
                    .offset(y:planetFiveBottom)
                InfoTextForSlideThree()
                    .offset(y:InfoTextForSlideBottom)
            }//:VSTACK
        }//:ZSTACK
        .overlay(
            PlanetSixImage()
        )
        .frame(maxWidth:.infinity,maxHeight: .infinity)
    }
}

struct WelcomeThree_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            InfoSlideThree()
                .previewDevice("iPhone 8")
            InfoSlideThree()
                .previewDevice("iPhone 13")
        }
    }
}

