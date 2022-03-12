//
//  InfoTextForSlideThree.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 18/12/21.
//

import SwiftUI

struct InfoTextForSlideThree: View {
    
     // MARK: - PROPERTIES
    
    var FontSize : CGFloat {
        return UIDevice.isIPad ? 32 :  20
    }
    
    
    // MARK: - Body
    
    var body: some View {
        
        Text("Cari uang tambahan\ndengan cara yang asik!\nLuncurkan Rocketmu sekarang!")
            .font(Font.custom("Avenir-Medium", size: FontSize))
            .multilineTextAlignment(.center)

            .padding([.leading,.trailing],20)
//            .padding(.top,10)
    }
}

struct InfoTextForSlideThree_Previews: PreviewProvider {
    static var previews: some View {
        InfoTextForSlideThree()
//            .previewLayout(.sizeThatFits)
    }
}
