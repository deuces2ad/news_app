//
//  CustomRoundedRectangleButton.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 31/12/21.
//

import SwiftUI

struct CustomRoundedRectangleButton: View {
    
     // MARK: - PROPERTIES
    
    typealias Action = () -> ()
    var action: Action
    
     // MARK: - BODY
    var body: some View {
        
        Button(action: action) {
            HStack{
                
                Image("arrowLeft-right")
                    .renderingMode(.template)
                    .foregroundColor(AppThemeConfig.orangeColor)
                
                
                Text("Transictions")
                    .frame(maxWidth:.infinity,alignment: .leading)
                    .foregroundColor(.black)
                    .font(Font.custom(AppThemeConfig.AvenirFont, size: 16).weight(.regular))
                    .padding(.leading)
                    .fixedSize()

                
                //"chevron.forward" is not available in iOS 13..
                Spacer()
                
                Image(systemName: "chevron.forward")
                    .renderingMode(.template)
                    .foregroundColor(AppThemeConfig.orangeColor)
                
            }
            .buttonStyle(.automatic)
            .frame(maxWidth:.infinity)
            .modifier(RectangularFrame())
        }


    }
}

struct CustomRoundedRectangleButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomRoundedRectangleButton(action: {})
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
