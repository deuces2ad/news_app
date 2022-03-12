//
//  InfoTextForSlideOne.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 18/12/21.
//

import SwiftUI

struct InfoTextForSlideOne: View {
    
     // MARK: - PROPERTIES
    
    var FontSize : CGFloat {
        return UIDevice.isIPad ? 32 :  20
    }
    
     // MARK: - BODY
    
    var body: some View {
        Text("Rocket siap berangkat dan bawa kamu belajar investasi reksadana!")
            .font(Font.custom("Avenir-Medium", size: FontSize))
            .multilineTextAlignment(.center)
            .padding(.bottom,20)
            .padding([.leading,.trailing],20)
    }
}


struct InfoTextForSlideOne_Previews: PreviewProvider {
    static var previews: some View {
        InfoTextForSlideOne()
//            .previewDe
    }
}
