//
//  CancelAppointmentController.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 17/09/21.
//

import Foundation
import UIKit

class CancelAppointmentController: InterfaceExtendedController {
    
    //MARK:-LifeCylce
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.controller = self
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    
    //MARK:- Set rootView
    lazy var rootView : CancelAppointmentRootView =  {
        let rootView = CancelAppointmentRootView()
        return rootView
    }()
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 2
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
