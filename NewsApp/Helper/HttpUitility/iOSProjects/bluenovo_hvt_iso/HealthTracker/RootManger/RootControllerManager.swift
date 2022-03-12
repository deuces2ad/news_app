//
//  RootControllerManager.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 27/07/21.
//

import Foundation
import UIKit

class RootControllerManager {
    
    private let TAG = "RootControllerManager"
    
    
    func setRoot(didLoadWindow:(()->())?){
        updateNavigationBar()
        LocationManager.shared.startUpdatingLocation  {
            
        }
        Log.echo(key: TAG, text: "Set Root Controller")
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        _ = appDelegate?.window
        
        
        delayLaunchScreen {
            self.showRelevantScreen {
                UserDefaults.standard.set(true, forKey: "isOnBoardShown")
                Log.echo(key: self.TAG, text: "START VALIDATING")
                didLoadWindow?()
            }
        }
        
    }
    
    func updateRoot(){
        self.showRelevantScreen {
        }
    }
    
    
    private func showRelevantScreen(didLoadWindow:(()->())?){
//        let _ =  NavigationBarCustomizer()
        
        let userInfo = SignedUserInfo.sharedInstance
        
        if !isOnBoardShowed(){
            Log.echo(key: self.TAG, text: "SHOW ONBOARD")
            showOnboardScreen(didLoadWindow:didLoadWindow)
            return
        }
        
        if(userInfo == nil){
            UserDefaults.standard.set(false, forKey: "isLanguageSet")
            showSigninScreen(didLoadWindow:didLoadWindow)
            return
        }

        
        if  let isLanguageSet = isLanguageSet(){
            if !isLanguageSet{
                showLanguagePrefernceScreen(didLoadWindow: didLoadWindow)
            }else{
                showHomeScreen(didLoadWindow: didLoadWindow)
            }
        }
    }
    
    func isOnBoardShowed()->Bool{
        
        guard let onboardStatus =  UserDefaults.standard.value(forKey: "isOnBoardShowed") as? Bool else{
            return false
        }
        return onboardStatus
    }
    
    private func isLanguageSet() ->Bool?{
        guard let isLanguageSet = UserDefaults.standard.value(forKey: "isLanguageSet") as? Bool else {
            return  false
        }
        return isLanguageSet
    }
    
    func showLanguagePrefernceScreen(didLoadWindow:(()->())?){
        guard let role = SignedUserInfo.sharedInstance?.role else{
            return
        }
        DispatchQueue.main.async {
            let appdelegate = UIApplication.shared.delegate as? AppDelegate
            let window = appdelegate?.window
            let transition = CATransition()
            transition.type = CATransitionType.fade
            
            if role == .patient{
                let setLanguageController = SetLanguageController()
                window?.rootViewController = setLanguageController
                window?.makeKeyAndVisible()
            }else{
                self.showHomeScreen(didLoadWindow: didLoadWindow)
            }
        }
    }
    
    private func showSigninScreen(didLoadWindow:(()->())?){
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let window = appDelegate?.window
    
        
        guard let signinController = SigninController.instance()
        else{
            return
        }
        signinController.didLoad = didLoadWindow
        let signinNav : UINavigationController = ExtendedNavigationController()
        signinNav.viewControllers = [signinController]
        window?.rootViewController = signinNav
    }
    
    private func showHomeScreen(didLoadWindow:(()->())?){
        
        DispatchQueue.main.async {
            
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let window = appDelegate?.window
            let _ : UINavigationController = ExtendedNavigationController()

            let transition = CATransition()
            transition.type = CATransitionType.fade
          
            let containerController = MainTabBarController()
            containerController.didLoad = didLoadWindow
            window?.rootViewController = containerController
            window?.makeKeyAndVisible()
//            didLoadWindow?()
        }
    }
    
    func getTopRootController() -> UIViewController? {
            let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) ?? UIApplication.shared.windows.first
            let topController = keyWindow?.rootViewController
            return topController
        }
    
    
    fileprivate func delayLaunchScreen(completion : @escaping (()->())){
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let window = appDelegate?.window
        window?.rootViewController = LaunchDelayController.instance()
        let when = DispatchTime.now() + 1
        //change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            completion()
            return
        }
    }
    
    
    fileprivate func showOnboardScreen(didLoadWindow:(()->())?){
        Log.echo(key: TAG, text: "ONBOARD FLOW SCREEN SHOWN")
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let window = appDelegate?.window
        let _ : UINavigationController = ExtendedNavigationController()
        let transition = CATransition()
        transition.type = .fade
        guard let onboardController = OnBoardFlowController.instance() else{
            return
        }
        onboardController.didLoad = didLoadWindow
        let signinNav : UINavigationController = ExtendedNavigationController()
        window?.rootViewController = signinNav
        signinNav.viewControllers = [onboardController]
        window?.makeKeyAndVisible()
        
    }
    
    fileprivate func showTestController(didLoadWindow:(()->())?){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let window = appDelegate?.window
        let _ : UINavigationController = ExtendedNavigationController()
        let transition = CATransition()
        transition.type = .fade
        let signinNav : UINavigationController = ExtendedNavigationController()
        window?.rootViewController = signinNav
        signinNav.viewControllers = [CancelAppointmentController()]
        window?.makeKeyAndVisible()
    }
    
    func signOut(completion : (()->())?){
        SignedUserInfo.sharedInstance?.clear()
        RootControllerManager().updateRoot()
        UserDefaults.standard.removeObject(forKey: "isLanguageSet")
        UserDefaults.standard.removeObject(forKey: LanguageKey)
    }
    
    func getCurrentController()->MainTabBarController?{
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let root = appDelegate?.window?.rootViewController as? MainTabBarController
        return root
    }
    
    private func updateNavigationBar(){
//        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = UIColor(hexString: AppThemeConfig.greenColor)
        UINavigationBar.appearance().barTintColor = UIColor(hexString: AppThemeConfig.greenColor)
//        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.red]
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            let navigationBar = UINavigationBar()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            appearance.backgroundColor = AppThemeConfig.DarkGreen
            navigationBar.standardAppearance = appearance;
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
}
}
