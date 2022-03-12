//
//  PlanetSixImage.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 18/12/21.
//

import SwiftUI

struct PlanetSixImage: View {
    
     // MARK: - IMAGESIZE
    
    var planetSixSize :CGFloat{
        return UIDevice.isIPad ? 350 : 188
    }
    
    var planetSixYAxis :CGFloat{
        return UIDevice.isIPad ? -220 : -100
    }
    
    // MARK: - BODY
    
    var body: some View {
        VStack{
            Image("planetSix")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: planetSixSize, height: planetSixSize)
        }
        .offset(y:planetSixYAxis)
    }
}

struct PlanetSixImage_Previews: PreviewProvider {
    static var previews: some View {
        PlanetSixImage()
    }
}
