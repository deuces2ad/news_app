//
//  SecureTextField.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 17/12/21.
//

import SwiftUI

struct CustomSecureTextFild: View {
    
     // MARK: - PROPERTIES
    
    var title : String
    var placeHolderText : String
    
    private var fontSize : CGFloat{
        return UIDevice.isIPad ? 27 : 18
    }
    
    @Binding var userPassword : String
    @State private var isSecured : Bool = false

     // MARK: - BODY
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading){
                
                Text(title)
                    .font(Font.custom(AppThemeConfig.AvenirFont, size: fontSize))
                 
        
                HStack{
                    if isSecured{
                        SecureField(placeHolderText, text: $userPassword)
                            .font(Font.custom(AppThemeConfig.AvenirFont, size: fontSize))
                            .textFieldStyle(MyTextFieldStyle())
                    }else{
                        TextField(placeHolderText, text: $userPassword)
                          .font(Font.custom(AppThemeConfig.AvenirFont, size: fontSize))
                          .textFieldStyle(MyTextFieldStyle())
//                          .background(Color.red)
                        
                    }
                    
                }//:HSTACK
            }
        } .overlay(
            Button(action: {isSecured.toggle()}) {
                Image(systemName: isSecured ? "eye.slash" : "eye.fill")
                    .resizable()
                    .foregroundColor(Color(hex: "6E6E6E"))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .padding(.vertical,15)
                    .padding(.horizontal,15)
            }
            ,alignment: .bottomTrailing
        )
    }
}

struct SecureTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomSecureTextFild(title: "Password", placeHolderText: "Password", userPassword: .constant("000000"))
            .previewLayout(.sizeThatFits)
    }
}
