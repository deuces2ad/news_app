//
//  PlanetOneImage.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 18/12/21.
//

import SwiftUI

struct PlanetOneImage: View {
    
    // MARK: - IMAGE SIZE
    
    var planetOneSize :CGFloat{
        return UIDevice.isIPad ? 300 : 150
    }
    
    var planetOneOffset :CGFloat{
        return getRect().height < 750 ? 50 : -5
    }
    
    // MARK: - BODY
    
    var body: some View {
        HStack{
            Image("planetOne")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: planetOneSize, height: planetOneSize)
            Spacer()
        }
    }
}

struct PlanetOneImage_Previews: PreviewProvider {
    static var previews: some View {
        PlanetOneImage()
    }
}
