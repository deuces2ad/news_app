//
//  LocationEmiterRequest.swift
//  HealthTracker
//
//  Created by Grazitti on 22/09/21.
//

import Foundation


struct LocationEmiterRequest : Encodable {
    
    var latitude, longitude : String?
    var appointment_id : String?
}
