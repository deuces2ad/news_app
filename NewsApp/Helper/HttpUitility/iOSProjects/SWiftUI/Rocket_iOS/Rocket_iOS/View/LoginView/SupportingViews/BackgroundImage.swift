//
//  BackgroundImage.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 17/12/21.
//

import SwiftUI

struct BackgroundImage: View {
    
     // MARK: - Image Size

    var screenSize : CGSize
    var imageName : String
    var contentMode : ContentMode
    var backgroundColor : Color
    
     // MARK: - BODY
    
    var body: some View {

        ZStack {
            backgroundColor
              
                .frame(maxWidth:.infinity,alignment: .topLeading)
                .overlay(
                    VStack{
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: screenSize.width)
                        Spacer()
                    }
                )
        }
        .edgesIgnoringSafeArea(.top)
            
    }
}

//struct BackgroundImage_Previews: PreviewProvider {
//    static var previews: some View {
//        Group{
//            BackgroundImage()
//        }
//
//    }
//}
