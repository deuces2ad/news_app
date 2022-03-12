//
//  CustomDreamView.swift
//  Rocket_iOS
//
//  Created by Apple on 28/01/22.
//

import SwiftUI

struct CustomDreamView: View {
    @State var username: String = ""
 


    var body: some View {
        
        VStack{
            NavigationBar(title: .constant("Dream Come True"))
            
          Text("Dream Come True")
                .font(.custom(AppThemeConfig.AvenirFont, size: 20).weight(.regular))
            
            
            Button(action: {
                
            }) {
                PlaceholderImageView()
            }
            
            
            HStack{
                Text("Nama Impanian").font(.custom(AppThemeConfig.AvenirFont, size: 20))
                
                Spacer()
            }
            .padding(.top,50)
            
            TextField("Enter your name...", text: $username)
                .modifier(RectangularFrame())
          
            Spacer()
        }
        .padding()
        .frame(maxWidth:.infinity,maxHeight:.infinity)
    }
}

struct CustomDreamView_Previews: PreviewProvider {
    static var previews: some View {
        CustomDreamView()
    }
}

struct PlaceholderImageView: View {
    @State private var phase: CGFloat = 0
    
    var body: some View {
        Rectangle()
        
            .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [10], dashPhase: phase))
            .frame(width: 150, height: 150)
            .foregroundColor(AppThemeConfig.LightGray)
            .cornerRadius(8)
            .overlay(
                ZStack{
                    VStack{
                        Image("imagePlaceholder")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .aspectRatio(contentMode: .fit)
                        
                        Text("Dream photo")
                            .modifier(LightGrayTitle())
                    }
                    
                    
                }
            )
    }
}
