//
//  AppDelegate.swift
//  ECommerceAppSwiftUI
//
//  Created by Abhishek Dhiman on 13/12/21.
//  Copyright © 2021 Abhishek Dhiman. All rights reserved.
//

import UIKit
import SwiftUI
import IQKeyboardManagerSwift

class AppDelegate: NSObject, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
      
        let spalshView = SplashView()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UIHostingController(rootView: spalshView)
        self.window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        
        if(AppOrientation.allowRotate){
            return .allButUpsideDown
        }
        //Only allow portrait (standard behaviour)
        return .portrait
    }
}
