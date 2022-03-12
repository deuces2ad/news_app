//
//  UserTypeController.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 29/07/21.
//

import Foundation
import UIKit

class UserTypeController: InterfaceExtendedController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction fileprivate func setupDoctorProfile(){
        
    }
    
    @IBAction fileprivate func setupPatientProfile(){
        
    }
}

extension UserTypeController {
    class func instance() -> UserTypeController?{
        
        let storyboard = UIStoryboard(name: "userType", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "UserTypeController") as? UserTypeController
        return controller
    }
}
