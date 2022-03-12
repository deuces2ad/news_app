//
//  CheckupController.swift
//  HealthTracker
//
//  Created by Apple on 07/10/21.
//

import Foundation
import UIKit

class CheckupController : InterfaceExtendedController{
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    
    override func loadView() {
        super.loadView()
        view = rootView
        rootView.controller = self
    }
    
    //MARK: - Set RootView
    lazy var rootView : CheckupRootView = {
        let rootView = CheckupRootView()
        return rootView
    }()
    
    func initialization(){
        paintInterface()
    }
    
    func paintInterface(){
        paintBackButton()
        paintNavigationTitle(text: "Checkout Patient")
    }
}
