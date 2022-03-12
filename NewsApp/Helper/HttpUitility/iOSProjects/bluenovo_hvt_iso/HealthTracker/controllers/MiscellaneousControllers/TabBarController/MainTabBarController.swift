//
//  MainTabBarController.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 29/07/21.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    let LightGreen  = UIColor(hexString: AppThemeConfig.lightGreen)
    let TAG = "MainTabBarController"
    var didLoad : (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTabBarControllers()
        
//        self.view.backgroundColor = AppThemeConfig.DarkGreen
//        self.navigationController?.navigationBar.tintColor = AppThemeConfig.DarkGreen
    }
    
    
    fileprivate func initializeTabBarControllers(){
        guard let role = SignedUserInfo.sharedInstance?.role else {
            Log.echo(key: TAG, text: "Oopps!! How did i get here")
            return
        }
        
        if role == .doctor{
            setupDoctorControllers()
            Log.echo(key: TAG, text: "Doctor Dashboard setup done!")
        }else{
            setupUserControllers()
            Log.echo(key: TAG, text: "User Dashboard setup done!")
        }
        setupTabbarPropeties()
        if let didload = self.didLoad {
            didload()
        }
    }

    
    fileprivate func setupDoctorControllers(){
        
        // Doctor Tab Bar Controllers
        let homeController = createNavController(with: HomeController(), selcted: UIImage(systemName: "house.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage(), unSelected: UIImage(systemName: "house")?.withTintColor(LightGreen, renderingMode: .alwaysOriginal) ?? UIImage(), title: "HOUSE")
        
        let eventController = createNavController(with: DoctorAppointmentsController(), selcted: UIImage(systemName: "calendar.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage(), unSelected: UIImage(systemName: "calendar")?.withTintColor(LightGreen, renderingMode: .alwaysOriginal) ?? UIImage(), title: "Appointments")
        
        viewControllers =  [homeController,eventController]
        
    }
    
    fileprivate func setupUserControllers(){
        
        let userDashBoard = createNavController(with: UserDashBoardController(), selcted: UIImage(systemName: "house.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal), unSelected: UIImage(systemName: "house")!, title: "HOME".localized() ?? "")
    
        
        let newEventController = createNavController(with: PatientAppointmentController(), selcted: UIImage(systemName: "calendar")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage(), unSelected: UIImage(systemName: "calendar")?.withTintColor(LightGreen, renderingMode: .alwaysOriginal) ?? UIImage(), title: "Appointment".localized() ?? "")
        
        
        viewControllers = [userDashBoard,
                           newEventController]
                           
        
    }
    
    
    fileprivate func setupTabbarPropeties(){
       
        if #available(iOS 15.0, *) {
            updateTabBarAppearance()
        } else {
            UITabBar.appearance().barTintColor = UIColor(hexString: AppThemeConfig.greenColor)
            UITabBar.appearance().isTranslucent = false
            //
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white,
                                                              NSAttributedString.Key.font : UIFont(name: AppThemeConfig.boldFont, size: 12)!],
                                                             for: .selected)
            //
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray,
                                                              NSAttributedString.Key.font : UIFont(name: AppThemeConfig.boldFont, size: 12)!],
                                                             for: .normal)
            
        }
        
    }
    
    @available(iOS 15.0, *)
    private func updateTabBarAppearance() {
        let appereance = UITabBarAppearance()
    
        appereance.configureWithOpaqueBackground()
        appereance.backgroundColor = AppThemeConfig.DarkGreen
        appereance.selectionIndicatorTintColor = .red
      
        appereance.inlineLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        appereance.compactInlineLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        appereance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
         
        self.tabBar.standardAppearance = appereance
        self.tabBar.scrollEdgeAppearance = appereance
    }

    @available(iOS 13.0, *)
    private func updateTabBarItemAppearance(appearance: UITabBarItemAppearance) {
        let tintColor: UIColor = .white
        let unselectedItemTintColor: UIColor = .red
        
        appearance.selected.iconColor = tintColor
        appearance.normal.iconColor = unselectedItemTintColor
        
    }
    
}

extension MainTabBarController {
    func createNavController(with controller : UIViewController, selcted: UIImage, unSelected: UIImage, title :String) -> UINavigationController{
        let vc = controller
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.tabBarItem.image = unSelected
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.selectedImage = selcted
        return navigationController
    }
}
   


