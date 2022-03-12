//
//  PlanetFiveImage.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 18/12/21.
//

import SwiftUI

struct PlanetFiveImage: View {
    
     // MARK: - ImageSize
    
    var planetFiveSize :CGFloat{
        return UIDevice.isIPad ? 250 : 110
    }
    
    var planetSevenBottom :CGFloat{
        return UIDevice.isIPad ? 220 : 100
    }
    
 
    // MARK: - BODY
    
    var body: some View {
        VStack {
            Spacer(minLength: 60)
            HStack{
                
                Image("planetFive")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: planetFiveSize, height: planetFiveSize)
                Spacer()
            }//:HSTAC
            .padding(.bottom,planetSevenBottom)
        }
    }
}

struct PlanetFiveImage_Previews: PreviewProvider {
    static var previews: some View {
        PlanetFiveImage()
    }
}
