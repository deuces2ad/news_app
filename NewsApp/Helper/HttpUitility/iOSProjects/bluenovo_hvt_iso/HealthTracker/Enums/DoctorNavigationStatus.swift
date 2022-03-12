//
//  DoctorNavigationStatus.swift
//  HealthTracker
//
//  Created by Apple on 07/10/21.
//

import Foundation

//
enum DoctorNavigationStatus : String,Encodable{
    case  pending = "PENDING"
    case  enroute = "ENROUTE"
    case  cancelled = "CANCELLED"
    case  cancelledRequested = "CANCELREQUESTED"
    case  completed = "COMPLETED"
}
