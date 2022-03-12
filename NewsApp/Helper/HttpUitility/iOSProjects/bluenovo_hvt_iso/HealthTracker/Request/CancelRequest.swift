//
//  CancelRequest.swift
//  HealthTracker
//
//  Created by Apple on 18/10/21.
//

import Foundation

struct CancelRequest : Encodable{
    let appointment_id : Int?
    let reason : String?
}
