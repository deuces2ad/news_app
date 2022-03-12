//
//  VerifyEmailBanner.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 28/12/21.
//

import SwiftUI

struct VerifyEmailBanner: View {
    
     // MARK: - PROPERTIES
    let TAG = "VerifyEmailBanner"
    
//    typealias Action = () -> ()
//    var action: Action
    
    // MARK: - BODY
    
    var body: some View {
        Rectangle()
            .frame(width: getRect().width, height: 70)
            .foregroundColor(AppThemeConfig.themeLightYellowColor)
            .overlay(
                GeometryReader{ _ in
                    HStack(spacing:20){
                        Image(systemName: "envelope")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(AppThemeConfig.orangeColor)
                            .background(
                                Circle()
                                    .frame(width: 37, height: 37)
                                    .foregroundColor(AppThemeConfig.orangeColor)
                                    .overlay(
                                        Circle()
                                            .frame(width: 35, height: 35)
                                            .foregroundColor(AppThemeConfig.themeLightYellowColor)
                                    )
                            )
                            .padding(.leading,30)
                        
                        VStack(alignment: .leading){
                            Text("Email verification for transactions")
                                .foregroundColor(AppThemeConfig.themeLightBrownColor)
                                .font(Font.custom(AppThemeConfig.AvenirFont, size: 16))
                            
                            HStack{
                                Text("Didn't receive the message?")
                                    .fixedSize()
                                    .foregroundColor(AppThemeConfig.themeLightBrownColor)
                                    .font(Font.custom(AppThemeConfig.AvenirFont, size: 16))
                                
                                Button(action: {
                                    Log.echo(key: TAG, text: "Sned mail tapped")
                                    
                                }) {
                                    Text("Resend")
                                        .fixedSize()
                                        .foregroundColor(AppThemeConfig.themeLightBrownColor)
                                        .font(Font.custom(AppThemeConfig.AvenirFont, size: 16))
                                        .overlay(
                                            Rectangle()
                                                .frame(height: 1).offset(y: -2)
                                                .foregroundColor(AppThemeConfig.themeLightBrownColor)
                                            , alignment: .bottom
                                        )
                                }//BUtton
                                
                            }//HSTACK
                            
                        }//VSTACK
                        .padding(.leading)
                    }//HSTACK
                    .padding(.top,10)

                }//Geometry Reader
            )
    }
}

struct VerifyEmailBanner_Previews: PreviewProvider {
    static var previews: some View {
        VerifyEmailBanner()
            .previewLayout(.sizeThatFits)
    }
}
