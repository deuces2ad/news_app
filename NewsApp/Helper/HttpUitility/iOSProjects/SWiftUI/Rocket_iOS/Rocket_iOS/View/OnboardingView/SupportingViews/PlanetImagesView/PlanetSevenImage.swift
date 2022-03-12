//
//  PlanetSevenImage.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 18/12/21.
//

import SwiftUI

struct PlanetSevenImage: View {
    
     // MARK: - IMAGESIZE
    
    var planetSevenSize :CGFloat{
        return UIDevice.isIPad ? 200 : 100
    }
    
    var planetSevenYOffset :CGFloat{
        return UIDevice.isIPad ? 30 : 30
    }
    
    var planetSevenXOffset :CGFloat{
        return UIDevice.isIPad ? 0 : 0
    }
    
     // MARK: - BODY
    
    var body: some View {
        HStack(alignment: .top){
            Image("planetSeven")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: planetSevenSize, height: planetSevenSize)
        }//:HSTACK
        
        .frame(maxWidth:.infinity,alignment: .trailing)
        .offset(y:planetSevenYOffset)
    }
}


struct PlanetSevenImage_Previews: PreviewProvider {
    static var previews: some View {
        PlanetSevenImage()
//            .previewLayout(.sizeThatFits)
    }
}
