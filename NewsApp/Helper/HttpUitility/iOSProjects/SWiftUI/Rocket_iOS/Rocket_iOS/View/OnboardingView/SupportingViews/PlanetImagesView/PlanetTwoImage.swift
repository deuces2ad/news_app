//
//  PlanetTwoImage.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 18/12/21.
//

import SwiftUI

struct PlanetTwoImage: View {
    
     // MARK: - IMAGE SIZE
    
//    var planetTwoSize :CGFloat{
//        return getRect().height < 750 ? 195 : 200
//    }
    
    var planetTwoSize :CGFloat{
        return UIDevice.isIPad ? 300 : 150
    }
    
    var planteTwoOffset :CGFloat{
        return UIDevice.isIPad ? 30 : 15
    }
    
     // MARK: - BODY
    
    var body: some View {
        HStack{
            Spacer()
            Image("planetTwo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: planetTwoSize, height: planetTwoSize)
                .offset(x:planteTwoOffset)
        }//:HSTACK
        .padding(.top,-10)
    }
}
struct PlanetTwoImage_Previews: PreviewProvider {
    static var previews: some View {
        PlanetTwoImage()
            
    }
}
