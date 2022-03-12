//
//  AlertViewController.swift
//  Health Tracker
//
//  Created by Abhishek Dhiman on 27/07/21.
//  Copyright © 2021 Abhishek Dhiman. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func alert(withTitle title : String = AppInfoConfig.appName, message : String = "", successTitle : String = "", rejectTitle : String = "", showCancel : Bool = false, completion : ((_ success : Bool)->())? = nil
        ){
        
        let alertController = UIAlertController(title: title , message: message, preferredStyle: .alert)
        
        var successTitle = successTitle
        
        if(successTitle == ""){
            successTitle = showCancel ? "Yes": "OK"
        }
        
        var rejectTitle = rejectTitle
        
        if(rejectTitle == ""){
            rejectTitle = "No"
        }
        
        
        let successAction = UIAlertAction(title: successTitle, style: .default) { (action) in
            completion?(true)
            return
        }
        
        
        let rejectAction = UIAlertAction(title: rejectTitle, style: .cancel) { (action) in
            completion?(false)
            return
        }
        
        if(showCancel){
            alertController.addAction(rejectAction)
        }
        alertController.addAction(successAction)
       
        
        
        present(alertController, animated: true, completion: nil)
        
    }
}
