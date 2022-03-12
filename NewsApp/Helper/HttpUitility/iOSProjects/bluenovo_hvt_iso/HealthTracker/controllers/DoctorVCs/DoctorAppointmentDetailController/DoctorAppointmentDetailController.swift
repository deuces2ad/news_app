//
//  AppointmentDetailController.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 15/08/21.
//

import Foundation
import UIKit


class DoctorAppointmentDetailController: DetailAppointmentController {
    
   
//MARK: -LifeCylce
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAppointmentInfo()
    }

    override func completeAppointment(){
        let request  = EnrouteStatusRequest(appointment_id: self.appointment_id,status: .completed)
        
        EnrouteStatusService().updateInfo(for: request) { response in
            
            DispatchQueue.main.async {
                self.stopLoader()
                
                if response?.success == true{
                    RootControllerManager().updateRoot()
                }else{
                    RootControllerManager().getTopRootController()?.alert(withTitle: AppInfoConfig.appName, message: response?.message ?? "Error Occured", successTitle: "OK", rejectTitle: "", showCancel: false, completion: nil)
                }
                
            }
        }
    }
    
}

