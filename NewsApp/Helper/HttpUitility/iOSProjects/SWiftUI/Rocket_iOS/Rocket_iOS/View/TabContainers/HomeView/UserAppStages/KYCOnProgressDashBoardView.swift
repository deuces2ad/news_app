//
//  KYCOnProgressDashBoardView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 28/12/21.
//

import SwiftUI

struct KYCOnProgressDashBoardView: View {
    
     // MARK: - PROPERTIES
    
    var containerSize : CGFloat {
        return UIDevice.isIPad ? 0.25
        :
        UIDevice.hasNotch ? 0.30 : 0.32
    }
    
    var imageSize: CGFloat{
        return UIDevice.isIPad ? 0.20 : 0.25
    }
    
    var fontSize: CGFloat{
        return UIDevice.isIPad ? 21 : 18
    }
    
    var body: some View{
        
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
                        .padding(.top)
                        .padding(.horizontal,15)
                )
            
            ScrollView(.vertical,showsIndicators: false){
                VStack{
                    VStack{
                        TimelLineItemView(screenSize: getRect().size)
                            .background(Color.white)
                            .cornerRadius(8.0)
                            .padding(25)
                            .shadow(radius: 3)
                        
                    }
                   
                    VStack{
                        Image("mimpi")
                        
                        Group{
                            Text("Bangun Impianmu")
                                .font(Font.custom(AppThemeConfig.AvenirFont, size: 16).weight(.semibold))
                            Text("Penjelasan deskriptif singkat")
                                .font(Font.custom(AppThemeConfig.AvenirFont, size: 14).weight(.regular))
                        }
                        .foregroundColor(AppThemeConfig.themeLightBrownColor)
                 
                        NavigationLink(destination: CreateNewGoalView()) {
                            Text("Start")
                                .padding(.vertical,10)
                                .frame(width: 200)
                                .modifier(CustomButtonStyle(forgroundColor: AppThemeConfig.themeYellowColor))
                        }
                    }
                    .padding()
                    .frame(maxWidth:.infinity)
                    .background(AppThemeConfig.themeLightYellowColor)
                    
                }
            }
            .frame(maxWidth:.infinity,maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
            )
        }
        .modifier(HideNavigationBar())
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background(AppThemeConfig.themeLightYellowColor)
        .edgesIgnoringSafeArea(.all)
    }
}

struct KYCOnProgressDashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            KYCOnProgressDashBoardView()
                .previewDevice(DeviceList.iPhone13)
            KYCOnProgressDashBoardView()
                .previewDevice(DeviceList.iPhone8)
            KYCOnProgressDashBoardView()
                .previewDevice(DeviceList.iPadMini6ThGeneration)
           
            
        }
    }
}


struct PortfolioInfoView: View {
    
     // MARK: - PROPERTIES
    
    var fontSize: CGFloat{
        return UIDevice.isIPad ? 21 : 18
    }
    
     // MARK: - BODY
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            Text("Total Portfolio")
                .foregroundColor(AppThemeConfig.themeLightBrownColor)
                .font(Font.custom(AppThemeConfig.AvenirFont, size: fontSize))
            
            Text("Rp 0")
                .font(Font.custom(AppThemeConfig.AvenirFont, size: fontSize).weight(.heavy))
                .foregroundColor(AppThemeConfig.themeLightBrownColor)
            
        }//VSTACK
        .padding(.top)
    }
}



struct YieldInfoView: View {
    
     // MARK: - PROPERTIES
    
    var fontSize: CGFloat{
        return UIDevice.isIPad ? 21 : 18
    }
    
     // MARK: - BODY
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            
            Text("Yield")
                .foregroundColor(AppThemeConfig.themeLightBrownColor)
                .font(Font.custom(AppThemeConfig.AvenirFont, size: fontSize))
                .padding(.top,2)
            
            
            HStack{
                Image("arrowtriangle.up.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 14)
                
                Text("Rp 0 (0%)")
                    .foregroundColor(AppThemeConfig.themeGreenColor)
                    .font(Font.custom(AppThemeConfig.AvenirFont, size: fontSize))
                    .padding(.horizontal,5)
            }
        }
    }
}
