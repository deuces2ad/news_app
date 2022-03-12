//
//  OnboardingView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 15/12/21.
//

import SwiftUI

struct OnboardingView: View {
    
     // MARK: - PROPERTIES
     static let subviews = [
            UIHostingController(rootView: InfoSlideOne()),
            UIHostingController(rootView: InfoSlideTwo()),
            UIHostingController(rootView: InfoSlideThree())
        ]
    let TAG = "OnboardingView"
    
    @State var currentPageIndex : CGFloat = 0
    @State var isLastIndex :Bool = false
    @State private var showLogin = false
    
     // MARK: - Init()
    
    init(){
        let navbarApperance = UINavigationBarAppearance()
        navbarApperance.titleTextAttributes = [.foregroundColor:UIColor.red]
        navbarApperance.largeTitleTextAttributes = [.foregroundColor:UIColor.red]
        navbarApperance.backgroundColor = .yellow
        navbarApperance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = navbarApperance
        UINavigationBar.appearance().compactAppearance = navbarApperance
        UINavigationBar.appearance().scrollEdgeAppearance = navbarApperance
        UINavigationBar.appearance().prefersLargeTitles = false
        UINavigationBar.appearance().tintColor = UIColor.yellow
        UINavigationBar.appearance().isHidden = true
    }
    
    
     // MARK: - BODY
    
    var body: some View {
        
        GeometryReader{proxy in
            
            let size = proxy.size
            
            SubView(screenSize: size)
            
        }
        
    }
     // MARK: - METHODS
    func slideToNextPage(){
        if self.currentPageIndex == 1 {
            currentPageIndex += 1
            isLastIndex = true
        }else{
            currentPageIndex += 1
            isLastIndex = false
        }
    }
}
// MARK: - Preview..
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            OnboardingView()
                .previewDevice("iPhone 8")
            OnboardingView()
                .previewDevice("iPhone 13")
        }
      
    }
}

extension View {
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
}

