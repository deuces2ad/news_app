//
//  SigninButtonContainer.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 27/07/21.
//
//

import UIKit

class SigninButtonContainer: ExtendedView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        initialization()
    }
    
    fileprivate func initialization(){
        
        layer.cornerRadius = UIDevice.current.userInterfaceIdiom == .pad ? 5:3
        clipsToBounds = true
    }

}
