//
//  PlanetThreeImage.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 18/12/21.
//

import SwiftUI

struct PlanetThreeImage: View {
    
     // MARK: - IMAGESIZE
    
    var planetThreeSize :CGFloat{
        return UIDevice.isIPad ? 350 : 150
    }
    
    var planetThreeOffset :CGFloat{
        return UIDevice.isIPad ? 30 : 15
    }
    
     // MARK: - BODY
    
    var body: some View {
        HStack{
            Image("planetThree")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: planetThreeSize, height: planetThreeSize)
            Spacer()
        }
    }
}

struct PlanetThreeImage_Previews: PreviewProvider {
    static var previews: some View {
        PlanetThreeImage()
            .previewDevice("iPhone 13")
    }
}
