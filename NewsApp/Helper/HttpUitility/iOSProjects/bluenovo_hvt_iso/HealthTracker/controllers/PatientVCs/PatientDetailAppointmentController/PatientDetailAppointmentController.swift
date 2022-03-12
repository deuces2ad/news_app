//
//  PatientDetailAppointmentController.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 16/09/21.
//

import Foundation
import UIKit
import CoreLocation

class PatientDetailAppointmentController: DetailAppointmentController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        intialization()
    }
    
    
    func intialization(){
        getAppointmentInfo()
        rootView.tracktBtn.btn.addTarget(self, action: #selector(didTapOnTrackDoctor), for: .touchUpInside)
    }
//MARK: - Objc function
    
    @objc func didTapOnTrackDoctor(){
        let vc = PatientTrackingController()
        
        guard let currentLocation = LocationManager.shared.currentLocation?.location.coordinate else {
            return
        }
        vc.patientLocation = currentLocation
        navigationController?.pushViewController(vc, animated: true)
    }
    
  
}
