//
//  SigninController.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 27/07/21.
//

import Foundation
import UIKit


class SigninController: InterfaceExtendedController {
    
    
     // MARK: - LIfeCycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootview?.controller = self
    
    }
    
    var didLoad:(()->())?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        hideNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        showNavigationBar()
    }
    
     // MARK: - RootView
    
    var rootview : SigninRootView?{
        return self.view as? SigninRootView
    }
    
}

//
extension SigninController{
    
    class func instance()->SigninController?{
        
        let storyboard = UIStoryboard(name: "signin", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "signin") as? SigninController
        return controller
    }
}
