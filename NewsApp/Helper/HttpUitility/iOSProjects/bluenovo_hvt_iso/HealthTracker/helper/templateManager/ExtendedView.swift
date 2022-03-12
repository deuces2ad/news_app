//
//  ExtendedView.swift

//  Health Tracker
//
//  Created by Abhishek Dhiman on 27/07/21.
//  Copyright © 2021 Abhishek Dhiman. All rights reserved.
//

import UIKit

class ExtendedView: UIView {
    
    private var _isLoaded = false;
    
    var isLoaded : Bool{
        get{
            return _isLoaded
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if(!_isLoaded){
            _isLoaded = true
            viewDidLayout()
        }
    }
    
    
    func viewDidLayout(){
    }
}

