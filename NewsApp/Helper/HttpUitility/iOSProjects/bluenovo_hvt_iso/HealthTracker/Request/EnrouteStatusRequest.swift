//
//  EnrouteStatusRequest.swift
//  HealthTracker
//
//  Created by Apple on 07/10/21.
//

import Foundation


struct EnrouteStatusRequest : Encodable{
    var appointment_id: Int?
    var status : DoctorNavigationStatus?
}


