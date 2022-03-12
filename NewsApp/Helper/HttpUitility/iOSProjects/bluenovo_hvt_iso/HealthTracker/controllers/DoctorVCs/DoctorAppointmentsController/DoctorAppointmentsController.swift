//
//  EventController.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 29/07/21.
//

import Foundation
import UIKit
import CoreLocation

class DoctorAppointmentsController: ParentAppointmentController {
    

    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        intializeVariable()
        setupDoctorAppointments()
    }
    
    func setupDoctorAppointments(){
        rootView.detailedTrackInfo.delagate = self
    }
}


extension DoctorAppointmentsController : DeatailedTrackInfoDelegate {
    func showWayPoints() {
        let controller = DetailedRoutesController(locations: self.appoitmentsLocations)
        controller.locations = appoitmentsLocations
        controller.appointmentArr = todayAppointmentsInfo
        
        if todayAppointmentsInfo.isEmpty{
            alert(withTitle: "HVT Tracker", message: "No Appointment to show!", successTitle: "Ok", rejectTitle: "", showCancel: false, completion: nil)
            return
        }
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
}


extension DoctorAppointmentsController : AppointmentsSortingDelegate{
    func didEndSorting(info: [Appointmensts]) {
        todayAppointmentsInfo = info
        DispatchQueue.main.async {
            self.rootView.controller?.handleSeletionOfTabs()
        }
       
    }
    

}

