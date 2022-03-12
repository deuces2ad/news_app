//
//  LoginView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 16/12/21.
//

import SwiftUI
import Combine


struct LoginView : View {
    
    @State var showHomeView : Bool = false
    
    init(){
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View{
        VStack{
            
            Image("loginBg")
                .resizable()
                .frame(width:getRect().width)
                .frame(height:getRect().height * 0.40)
                .aspectRatio(contentMode: .fit)

            LoginAndSignupFields()
//                .modifier(KeyBoard())
            .frame(maxWidth:.infinity,maxHeight: .infinity)
                .background(
                    Color.white
                        .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
                )
               
        }
        .background(AppThemeConfig.themeDarkBrown)
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .navigationBarTitle("My Title", displayMode: .inline)
        .embedInNavigationView()
//        .navigationViewStyle(StackNavigationViewStyle())
       

    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group{
            LoginView()
                .previewDevice(DeviceList.iPhone8)
            LoginView()
                .previewDevice(DeviceList.iPhone13)
//
            LoginView()
                .previewDevice(DeviceList.iPadMini6ThGeneration)

        }

    }
}

