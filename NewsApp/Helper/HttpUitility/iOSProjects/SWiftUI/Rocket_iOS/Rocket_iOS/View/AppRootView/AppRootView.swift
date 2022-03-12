//
//  AppRootView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 18/12/21.
//

import SwiftUI

struct AppRootView: View {
    
     // MARK: - Properties
  
    @State private var showHomeView : Bool = false

    
    // MARK: - Body
    
    var body: some View {
        
        Group{
            let root = RootControllerManager()
            
            if !root.username.isEmpty{
                 LoginView()
//                    .navigationBarHidden(true)

            }else{
                OnboardingView()
//                    .navigationBarHidden(true)
            }
        }
       
        
       
    }
}

struct AppRootView_Previews: PreviewProvider {
    static var previews: some View {
        AppRootView()
    }
}
