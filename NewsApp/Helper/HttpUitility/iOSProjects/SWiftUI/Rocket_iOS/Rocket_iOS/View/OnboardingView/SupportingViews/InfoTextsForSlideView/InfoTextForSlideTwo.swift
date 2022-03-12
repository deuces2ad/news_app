//
//  InfoTextForSlideTwo.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 18/12/21.
//

import SwiftUI

struct InfoTextForSlideTwo: View {
    
     // MARK: - BODY
    
    var FontSize : CGFloat {
        return UIDevice.isIPad ? 32 :  20
    }
    
    var body: some View {
        Text("Mimpi terus... nyampenya kapan nih? Nebeng Rocket aja!")
            .font(Font.custom("Avenir-Medium", size: FontSize))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding(.bottom,getRect().height < 750 ? 45:20)
            .padding([.leading,.trailing],20)
    }
}


struct InfoTextForSlideTwo_Previews: PreviewProvider {
    static var previews: some View {
        InfoTextForSlideTwo()
            .previewLayout(.sizeThatFits)
            .background(Color.red)
            
    }
}
