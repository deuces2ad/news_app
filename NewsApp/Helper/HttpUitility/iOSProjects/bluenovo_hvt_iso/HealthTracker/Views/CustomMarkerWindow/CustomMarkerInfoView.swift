//
//  CustomMarkerInfoView.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 11/08/21.
//

import Foundation
import UIKit
import CoreLocation

class  CustomMarkerInfoView: ExtendedView {
    
    var name : String?
    var locationl : String?
    
    override func viewDidLayout() {
        super.viewDidLayout()
        self.backgroundColor = .red
        layer.masksToBounds = true
        layer.cornerRadius = 5
    }
    
     init(frame: CGRect, userName : String,location :CLLocationCoordinate2D) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
