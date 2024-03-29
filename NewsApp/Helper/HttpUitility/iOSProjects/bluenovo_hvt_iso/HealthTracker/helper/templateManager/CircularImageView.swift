//
//  CircularImageView.swift
//  Health Tracker
//
//  Created by Abhishek Dhiman on 27/07/21.
//  Copyright © 2021 Abhishek Dhiman. All rights reserved.
//

import UIKit

class CircularImageView: ExtendedImageView {

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
    
    private func initialization(){
        initalizeUI()
    }
    
    private func initalizeUI(){
        
        let layer = self.layer
        layer.cornerRadius = self.bounds.width/2
        layer.borderWidth = 2.0
        layer.borderColor = UIColor(hexString: AppThemeConfig.themeColor).cgColor
        self.clipsToBounds = true
    }
}
