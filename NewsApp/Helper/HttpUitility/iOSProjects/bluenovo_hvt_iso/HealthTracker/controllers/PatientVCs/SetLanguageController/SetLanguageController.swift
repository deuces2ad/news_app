//
//  SetLanguageController.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 01/09/21.
//

import Foundation
import UIKit

class SetLanguageController: InterfaceExtendedController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        rootView.controller = self
    }
    
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    //MARK:- Set rootView
    
    lazy var rootView : SetLanguageRootView = {
        let rootView = SetLanguageRootView()
        return rootView
    }()
    func setTabBar(){
    
            UserDefaults.standard.setValue(true, forKey: "isLanguageSet")
            RootControllerManager().updateRoot()

    }
}
