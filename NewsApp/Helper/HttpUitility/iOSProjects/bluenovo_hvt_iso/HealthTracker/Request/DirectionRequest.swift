//
//  DirectionRequest.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 19/08/21.
//

import Foundation

struct DirectionRequest : Encodable {
    var origin,destination,key: String?
    var sensor = false
    var mode : DirectionMode?
    var waypoints : String?
    var avoid : String?
}


enum DirectionMode : String , Encodable{
    case driving
}
