//
//  RegisteredUserWithNOKYCDashBoardView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 28/12/21.
//

import SwiftUI
import ScrollViewProxy

struct RegisteredNoKYCDashBoardView: View {
    
    
    var body: some View {
        VStack {
            LoginedUserInfoTopView(userProfilePicture: "userImage", userName: "Abhishek Dhiman")
                .padding([.leading],10)
            
            ScrollView(.vertical, showsIndicators: false) { proxy in
                
                VStack {
                    VerifyEmailBanner()
                    CompleteYourProfileBanner()
                    BannersHorizontalGrid()
                    TokenRewardsDistribution(screenSize: getRect().size).scrollId(2)
                }//VSTACK
                
            }//ScrollView
            .padding(.bottom)
            
        }
    }
}

struct RegisteredUserWithNOKYCDashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        RegisteredNoKYCDashBoardView()
    }
}
