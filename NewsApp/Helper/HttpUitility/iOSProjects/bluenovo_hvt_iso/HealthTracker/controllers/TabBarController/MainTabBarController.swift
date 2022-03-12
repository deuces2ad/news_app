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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTabBarControllers()
      
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
    }

    
    fileprivate func setupDoctorControllers(){
        
        // Doctor Tab Bar Controllers
        let mapViewController = createNavController(with: GoogleMapViewController(), selcted: UIImage(systemName: "map.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage(), unSelected: UIImage(systemName: "map")?.withTintColor(LightGreen, renderingMode: .alwaysOriginal) ?? UIImage(), title: "Maps")
        
        
        let homeController = createNavController(with: HomeController(), selcted: UIImage(systemName: "house.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage(), unSelected: UIImage(systemName: "house")?.withTintColor(LightGreen, renderingMode: .alwaysOriginal) ?? UIImage(), title: "HOUSE")
        
        let eventController = createNavController(with: AppointmentsController(), selcted: UIImage(systemName: "calendar.circle.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage(), unSelected: UIImage(systemName: "calendar")?.withTintColor(LightGreen, renderingMode: .alwaysOriginal) ?? UIImage(), title: "Appointments")
        
        viewControllers =  [homeController,eventController,mapViewController]
        
    }
    
    fileprivate func setupUserControllers(){
        
        let userDashBoard = createNavController(with: UserDashBoardController(), selcted: UIImage(systemName: "house.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal), unSelected: UIImage(systemName: "house")!, title: "HOME".localized() ?? "")
        
        
       
        let notificationController = createNavController(with: NotificationController(), selcted: UIImage(systemName: "bell.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal), unSelected: UIImage(systemName: "bell")!, title: "Notifications".localized() ?? "")
        
        let newEventController = createNavController(with: NewScheduleController(), selcted: UIImage(systemName: "calendar")?.withTintColor(.white, renderingMode: .alwaysOriginal) ?? UIImage(), unSelected: UIImage(systemName: "calendar")?.withTintColor(LightGreen, renderingMode: .alwaysOriginal) ?? UIImage(), title: "New Appointment".localized() ?? "")
        
        
        viewControllers = [userDashBoard,
                           newEventController,
                           notificationController]
                           
        
        
    }
    
    
    fileprivate func setupTabbarPropeties(){
        UITabBar.appearance().barTintColor = UIColor(hexString: AppThemeConfig.greenColor)
        UITabBar.appearance().isTranslucent = false
    
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white,
                                                          NSAttributedString.Key.font : UIFont(name: AppThemeConfig.boldFont, size: 12)!], for: .selected)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(hexString: AppThemeConfig.lightGreen),
                                                          NSAttributedString.Key.font : UIFont(name: AppThemeConfig.boldFont, size: 12)!], for: .normal)
    }
    
}

extension MainTabBarController {
    func createNavController(with controller : UIViewController, selcted: UIImage, unSelected: UIImage, title :String) -> UINavigationController{
        let vc = controller
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.tabBarItem.image = unSelected
        navigationController.tabBarItem.title = title
        navigationController.tabBarController?.title = title
        vc.navigationItem.setHidesBackButton(true, animated:true)
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        vc.navigationController?.navigationBar.backItem?.title = ""
        vc.navigationController?.navigationBar.backItem?.hidesBackButton = true
        navigationController.tabBarItem.selectedImage = selcted
        return navigationController
    }
}
   

