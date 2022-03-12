//
//  LoginSignupViewForNonRegisteredUser.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 22/12/21.
//

import SwiftUI


struct LoginSignupViewForNonRegisteredUser: View {
    
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(AppThemeConfig.themeLightYellowColor)
                .frame(maxWidth:.infinity)
                .frame(height: 200)
                .overlay(
                    GeometryReader{ geometry in
                        HStack {
                            Image("halfRocket")
                                .frame(maxWidth:.infinity,alignment: .trailing)
                        }
                        ZStack{
                            
                            VStack(alignment: .leading, spacing: 10){
                                Group{
                                    Text("Selamat Datang!")
                                        .fontWeight(.bold)
                                    Text("Masuk atau Daftar untuk akses lebih banyak keseruan Rocket!")
                                }.foregroundColor(Color.init(hex: "824529"))
                                    .font(Font.custom(AppThemeConfig.AvenirFont, size: 16))
                            }
                            .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .topLeading)
                            .padding(.leading,10)
                            .padding(.top,30)
                    

                            
                            HStack(spacing: 10){
                                CustomButton(title: "Login", verticlePadding: 8, backgroundColor: AppThemeConfig.themeLightYellowColor) {
                                    //
                                }
                               
                                
                                CustomButton(title: "Signup", verticlePadding: 8, backgroundColor: AppThemeConfig.themeYellowColor){
                                    
                                    
                                }
                            }
                            .padding(.bottom,30)
                            .padding(.horizontal,20)
                            .frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .bottom)
                            
                        }
                        
                    }
                )
        }
    }
}

struct LoginSignupViewForNonRegisteredUser_Previews: PreviewProvider {
    static var previews: some View {
        LoginSignupViewForNonRegisteredUser()
    }
}
