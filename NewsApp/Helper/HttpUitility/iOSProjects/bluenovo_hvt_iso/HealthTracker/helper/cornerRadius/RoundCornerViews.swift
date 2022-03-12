//
//  RoundCornerViews.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 27/07/21.
//

import Foundation
import UIKit


class RoundCornerViews: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.bounds.height/2
        self.layer.masksToBounds = true
        
    }
    
}
