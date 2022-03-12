//
//  InputTextField.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 17/12/21.
//

import SwiftUI

struct CustomTextField: View {
    
     // MARK: - PROPERTIES
    
    var title : String
    var placeHolderText : String
    
    private var fontSize : CGFloat{
        return UIDevice.isIPad ? 27 : 18
    }
    
    @Binding var inputTxt : String
    
     // MARK: - BODY
   
    var body: some View {
        
        VStack(alignment: .leading){
            Text(title)
                .font(Font.custom(AppThemeConfig.AvenirFont, size: fontSize))
                .padding(.top,5)
            
            TextField(placeHolderText, text: $inputTxt)
                .font(Font.custom(AppThemeConfig.AvenirFont, size: fontSize))
                .textFieldStyle(MyTextFieldStyle())
                .padding(.top,-5)
                .disableAutocorrection(true)
                .autocapitalization(.none)
        }
        
    }
    
    struct InputTextField_Previews: PreviewProvider {
        static var previews: some View {
            CustomTextField(title: "Email", placeHolderText: "Enter your registered email..", inputTxt:.constant("test@gmail.com"))
                .previewLayout(.sizeThatFits)
        }
    }
}

struct MyTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding([.vertical,.horizontal],10)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(AppThemeConfig.LightGray, lineWidth: 1)
        )
    }
}
