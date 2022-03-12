//
//  WelcomeScreenController.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 29/07/21.
//

import Foundation
import UIKit

class WelcomeScreenController: InterfaceExtendedController {
    
    let TAG = "WelcomeScreenController"
    
    var signinController : SigninController?
    var userTypeController : UserTypeController? = UserTypeController()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    
    
    fileprivate func initialization(){
        rootView.controller = self
        setupController()
    }
    
    override func loadView() {
      super.loadView()
        view = rootView
    }
    
    fileprivate func setupController(){
        
        guard let signinVC = SigninController.instance() else{
            Log.echo(key: TAG, text: "No SigninController found!")
            return
        }
        
        guard let userTypeVC = UserTypeController.instance() else{
            Log.echo(key: TAG, text: "No signupController found!")
            return
        }
        self.userTypeController = userTypeVC
        self.signinController = signinVC
        
        self.addChild(signinVC)
        self.addChild(userTypeVC)
        
        self.view.addSubview(signinVC.view)
        self.view.addSubview(userTypeVC.view)
        
        signinVC.didMove(toParent: self)
        userTypeVC.didMove(toParent: self)
        
        signinVC.view.frame = rootView.bounds
        userTypeVC.view.frame = rootView.bounds
        userTypeVC.view.isHidden = true
        
    }
    
     func resetTabs(){
        self.signinController?.view.isHidden = true
        self.userTypeController?.view.isHidden = true
    }
    
    
    // MARK: - Properties
    lazy var rootView: WelcomeScreenRootView = {
      let view = WelcomeScreenRootView()
      return view
    }()
    
}

