//
//  Signupview.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 27/07/21.
//
//

import UIKit

class Signupview: ExtendedView {
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        initialization()
    }
    
    fileprivate func initialization(){
        
        layoutUI()
    }
    
    func layoutUI(){
        
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 3
        self.layer.borderColor = UIColor(red: 219.0/255.0, green: 219.0/255.0, blue: 219.0/255.0, alpha: 1).cgColor
        self.layer.masksToBounds = true
    }
}
