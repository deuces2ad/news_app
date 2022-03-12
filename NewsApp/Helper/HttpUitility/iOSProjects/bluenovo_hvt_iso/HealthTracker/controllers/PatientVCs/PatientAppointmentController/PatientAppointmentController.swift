//
//  PatientAppointmentController.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 15/09/21.
//

import Foundation
import UIKit

class PatientAppointmentController: ParentAppointmentController {
    
//    var didTapCellListner : (()->Void)?
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        intializeVariable()
        rootView.detailedTrackInfo.isHidden = true
        rootView.headerlbl.isHidden = true
        registerLostners()
        paintNavigationTitle(text: "Your Appointements".localized())
        
    }
   
    func registerLostners(){
        patientCellListner = { [weak self] appointmentInfo in
            
            let vc = PatientDetailAppointmentController(with: appointmentInfo)
            self?.navigationController?.pushViewController(vc, animated: true)
            Log.echo(key: "Result", text: "got the response")

        }
    }
    
}
    
