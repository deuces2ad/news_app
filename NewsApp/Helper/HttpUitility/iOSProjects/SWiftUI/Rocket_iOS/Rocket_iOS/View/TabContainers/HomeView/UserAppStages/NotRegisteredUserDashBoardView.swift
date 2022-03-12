//
//  NotRegisteredUserDashBoardView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 28/12/21.
//

import SwiftUI
import ScrollViewProxy


struct NotRegisteredUserDashBoardView: View {
    
    
    var body: some View {
        VStack {
            LoginedUserInfoTopView()
                .padding([.leading],10)
            
            ScrollView(.vertical, showsIndicators: false) { proxy in
                VStack {
                    LoginSignupViewForNonRegisteredUser()
                    BannersHorizontalGrid()
                    TokenRewardsDistribution(screenSize: getRect().size).scrollId(2)
                }//VSTACK
            }//ScrollView
            .navigationBarHidden(true)
            .padding(.bottom)
        }
    }
}

struct NotRegisteredUserDashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        NotRegisteredUserDashBoardView()
    }
}
