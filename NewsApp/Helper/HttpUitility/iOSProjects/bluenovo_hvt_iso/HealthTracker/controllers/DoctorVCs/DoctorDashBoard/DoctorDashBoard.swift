//
//  DoctorDashBoard.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 12/08/21.
//

import Foundation
import UIKit

class DoctorDashBoardController: GoogleMapViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intializeVariable()
    }
    
    func intializeVariable(){
        paintInterface()
        
    }
    
     func paintInterface() {
        paintNavigationTitle(text: "Doctor DashBord")
        view.backgroundColor = .systemBlue
    }
}
