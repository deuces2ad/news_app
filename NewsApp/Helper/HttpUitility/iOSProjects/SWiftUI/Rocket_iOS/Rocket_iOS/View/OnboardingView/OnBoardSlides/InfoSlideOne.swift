//
//  InfoSlideOne.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 15/12/21.
//

import SwiftUI

struct InfoSlideOne: View {

 // MARK: - BODY
    var body: some View {
        VStack{
            PlanetTwoImage()
            Spacer()
            PlanetOneImage()
            InfoTextForSlideOne()
                .padding()
            Spacer()
        }//VSTACK
    }
}

struct InfoSlideOne_Previews: PreviewProvider {
    static var previews: some View {
//        Group{
            InfoSlideOne()
                .previewDevice("iPhone 8")
            InfoSlideOne()
                .previewDevice("iPhone 13")
        InfoSlideOne()
            .previewDevice(DeviceList.iPadMini6ThGeneration)
//        }
    }
}





