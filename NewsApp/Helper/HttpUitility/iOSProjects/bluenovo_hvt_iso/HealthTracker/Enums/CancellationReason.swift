//
//  CancellationReason.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 19/09/21.
//

import Foundation

enum CancellationReason : String {
    case notAvailable = "Caregiver is not available"
    case doNotRequire = "Do not require this service"
    case conflictingAppointment  = "Has conflicting appointment"
    case other = "Others"
}
