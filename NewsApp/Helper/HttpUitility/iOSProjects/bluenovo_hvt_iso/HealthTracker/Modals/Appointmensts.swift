//
//  Appointmensts.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 15/08/21.
//

import Foundation
import CoreLocation

struct Appointmensts {
    var appointmentID , appointmentDate, weekID: Int?
    var visitType, notes : String?
    var patientName: String?
    var doctorName : String?
    var patientLoc : CLLocationCoordinate2D?
    var status : String?
}
