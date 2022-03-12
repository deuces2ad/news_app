//
//  ImageTextRowView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 30/12/21.
//

import SwiftUI

struct ImageTextRowView: View {
    
    var text:String
 
    var imageName:String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: imageName)
                    .resizable()
//                    .padding(.leading, 7)
                    .foregroundColor(AppThemeConfig.themeYellowColor)
                    .background(Color.black)
                    .frame(width: 35, height: 35,alignment: .center)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                
                Text(text)
                    .foregroundColor(Color.black)
                    .font(.system(size: 16, weight: Font.Weight.medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(EdgeInsets(top: 10, leading: 2, bottom: 10, trailing: 10))
                
                Spacer()
                
                
            }
            .padding()
            
        }
    }
}
struct ImageTextRowView_Previews: PreviewProvider {
    static var previews: some View {
        ImageTextRowView(text: "Lengkapi Profil", imageName: "checkmark.circle.fill")
    }
}
