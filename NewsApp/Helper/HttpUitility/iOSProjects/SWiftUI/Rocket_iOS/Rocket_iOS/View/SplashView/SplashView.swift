//
//  SplashView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 18/12/21.
//

import SwiftUI

struct SplashView: View {
    
     // MARK: - PROPERTIES
    
    @State private var showOnboardView : Bool = false
    
     // MARK: - BODY
    
    var body: some View {
        if showOnboardView{
            
            ZStack{
                
                AppRootView()
                    .navigationBarItems(trailing: EmptyView())
                    .navigationBarHidden(true)
            }
            .navigationBarItems(trailing: EmptyView())
            .edgesIgnoringSafeArea(.all)
            
        }else{
            ZStack{
                AppThemeConfig.orangeColor
                  
                VStack{
                    Spacer()
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 170, height: 170, alignment: .center)
                        .padding(.bottom,50)
                
                    Image("clouds")
                        .resizable()
                        .frame(maxWidth:.infinity,alignment: .center)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: getRect().width, height: 200, alignment: .center)
                        .padding()
                    
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        showOnboardView = true
                    }
                }
                .overlay (
                    Group{
                        if showOnboardView {
                                AppRootView()
                                .transition(.move(edge: .bottom))
                        }
                    })
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarItems(trailing: EmptyView())
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}

