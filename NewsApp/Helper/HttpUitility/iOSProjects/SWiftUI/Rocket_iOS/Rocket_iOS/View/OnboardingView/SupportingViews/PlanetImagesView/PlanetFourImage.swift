//
//  PlanetFourImage.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 18/12/21.
//

import SwiftUI

struct PlanetFourImage: View {
    
     // MARK: - IMAGESIZE
    
    var planetFourSize :CGFloat{
        return UIDevice.isIPad ? 350 : 150
    }
    
    var planetFourOffset :CGFloat{
        return UIDevice.isIPad ? 30 : 15
    }
    
     // MARK: - BODY
    var body: some View {
        HStack{
            Spacer()
            Image("planetFour")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: planetFourSize, height: planetFourSize)
                .offset(x:10)
        }
    }
}

struct PlanetFourImage_Previews: PreviewProvider {
    static var previews: some View {
        PlanetFourImage()
//            .previewLayout(.sizeThatFits)
    }
}
