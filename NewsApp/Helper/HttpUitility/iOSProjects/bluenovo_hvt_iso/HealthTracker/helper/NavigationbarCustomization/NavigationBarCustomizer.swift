//
//  NavigationBarCustomizer.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 27/07/21.
//

import Foundation
import UIKit

class NavigationBarCustomizer{
    
    init() {
        initialization()
    }
    
    fileprivate func initialization(){
     
        updateTint()
        updateStatusBar()
    }
    
    func updateTint(){
        
//        guard let info = SignedUserInfo.sharedInstance?.role else{
//            paintNavForUser()
//            return
//        }
//        if info == .analyst{
//            paintNavForAnalyst()
//        }else{
//            paintNavForUser()
//        }
    }
    
    private func paintNavForAnalyst(){
        
        let navigationBarAppearace = UINavigationBar.appearance()
        
        navigationBarAppearace.tintColor = UIColor.white
        navigationBarAppearace.barTintColor = UIColor.white
        navigationBarAppearace.isTranslucent = false
        
        //change navigation item title color
        navigationBarAppearace.titleTextAttributes =  [NSAttributedString.Key.foregroundColor:UIColor(red: 74.0/255.0, green: 74.0/255.0, blue: 74.0/255.0, alpha: 1)]
    }
    
    
    private func paintNavForUser(){
        
        let navigationBarAppearace = UINavigationBar.appearance()
        
        navigationBarAppearace.tintColor = AppThemeConfig.navigationBarColor
        navigationBarAppearace.barTintColor = AppThemeConfig.navigationBarColor
        
//        navigationBarAppearace.tintColor = UIColor.white
//        navigationBarAppearace.barTintColor = UIColor.white
        navigationBarAppearace.isTranslucent = true
        
        //change navigation item title color
        navigationBarAppearace.titleTextAttributes =  [NSAttributedString.Key.foregroundColor:UIColor.white]
    }
    
    func updateStatusBar(){
    
    }
}
