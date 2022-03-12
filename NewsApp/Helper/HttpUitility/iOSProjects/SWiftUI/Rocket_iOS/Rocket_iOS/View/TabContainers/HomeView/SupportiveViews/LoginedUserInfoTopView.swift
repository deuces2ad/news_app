//
//  LoginedUserInfoTopView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 22/12/21.
//

import SwiftUI

struct LoginedUserInfoTopView: View {
    
     // MARK: - Properties
    
    @State private var amountTxt : String = "0"
    
    var userProfilePicture : String?
    var userName : String?
    
     // MARK: - Body
    
    var body: some View {
        HStack{
            // Light Yellow Circular..
            
            if let userImage = userProfilePicture {
                Image(userImage)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
              
            }else{
                Image("placeHolderImg")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            }

        
            VStack(alignment: .leading, spacing:0){
                Text("Halo,")
                    .font(Font.custom(AppThemeConfig.AvenirFont, size: 14))
                Text( userName ?? "Team Rocket!")
                    .font(Font.custom(AppThemeConfig.AvenirFont, size: 16))
                    .foregroundColor(AppThemeConfig.orangeColor)
                
            }//VSTACK
            
            Spacer()
            
            // Light Yellow Capsule..
            Capsule()
                .frame(width: 70, height: 39)
                .foregroundColor(Color.init(hex: "FEF6D8"))
//                .foregroundColor(userProfilePicture ? Color.init(hex: "FEF6D8") : Color.white)
                .overlay(
                    
                    ZStack{
                    
                        HStack {
                            
                            RocketInsideCircularStroke()

                            Text(amountTxt)
                                .font(Font.custom(AppThemeConfig.AvenirFont, size: 16).bold())
                                .foregroundColor(AppThemeConfig.themeLightBrownColor)
                            
                        }//HSTACK
    
                    }//ZSTACK
                )
        }//HSTACK
        .frame(height: 50)
    }
        


struct LoginedUserInfoTopView_Previews: PreviewProvider {
    static var previews: some View {
        LoginedUserInfoTopView()
            .previewLayout(.sizeThatFits)
    }
}


}
