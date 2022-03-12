//
//  ForgotPasswordView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 17/12/21.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
        
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Dismiss controller!!")
            }
        }
        .background(Color.red)
        .navigationBarHidden(true)
        .navigationBarTitle("Forgot password", displayMode: .inline)
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
