//
//  KYCApprovedDashBoardView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 28/12/21.
//

import SwiftUI

struct KYCApprovedDashBoardView: View {
    
     // MARK: - PROPERTIES
    let TAG = "KYCApprovedDashBoardView"
    @State private var showMyPortfolioList : Bool = false
   
    var containerSize : CGFloat {
        return UIDevice.isIPad ? 0.25
        :
        UIDevice.hasNotch ? 0.33 : 0.35
    }
    
     // MARK: - BODY
    
    var body: some View{
        
        let size = getRect().size
        
        VStack{
            Image("homeBg")
                .resizable()
                .frame(width: getRect().width, height: getRect().height * containerSize)
                .aspectRatio(contentMode: .fit)
                .overlay(
                    
                    VStack(alignment: .leading, spacing: 10){
                        LoginedUserInfoTopView(userProfilePicture: "userImage",userName: "Charli Jane")
                        PortfolioInfoView()
                        HStack {
                            
                            YieldInfoView()
                            Spacer()
                            NavigationLink(destination: MyPortfolioListView()
                                           , label: {
                                Text(" Portfolio")
                                    .foregroundColor(AppThemeConfig.themeLightBrownColor)
                                    .padding([.horizontal,.vertical],10)
                                    .background(AppThemeConfig.themeYellowColor)
                                    .clipShape(Capsule())
                            })
                                .navigationBarBackButtonHidden(true)
                                .buttonStyle(.automatic)
                        }
                    }
                        .frame(maxHeight:.infinity)
                        .padding(.horizontal,15)
                )
            
            
            ScrollView(.vertical,showsIndicators: false){
                
                VStack(alignment: .leading, spacing: 10){
                    
                    ScrollView(.horizontal , showsIndicators: false){
                        
                        HStack(spacing:10){
                            DreamCardView(screenSize: size)
                            DreamCardView(screenSize: size)
                            DreamCardView(screenSize: size)
                        }
                        .padding([.vertical],5)
                        
                    }
                    
                    CustomRoundedRectangleButton{
                        Log.echo(key: TAG, text: "Trasnation Tapped")
                    }
                    
                    TokenRewardsDistribution(screenSize: getRect().size)
                    
                }
                .padding(25)
                //                .background(Color.red)
                
            }
            .frame(maxWidth:.infinity,maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
            )
            
        }
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(AppThemeConfig.themeLightYellowColor)
        .edgesIgnoringSafeArea(.top)
    }
    

struct KYCApprovedDashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            KYCApprovedDashBoardView()
                .previewDevice(DeviceList.iPhone8)
            KYCApprovedDashBoardView()
                .previewDevice(DeviceList.iPhone13)
            KYCApprovedDashBoardView()
                .previewDevice(DeviceList.iPadMini6ThGeneration)
        }
    }
}
}
