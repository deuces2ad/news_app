//
//  MyProfileController.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 29/07/21.
//

protocol SetImageDelegate : class {
    func setImage(with image: UIImage)
}

import Foundation
import UIKit

class MyProfileController: InterfaceExtendedController {
    
    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        intialization()
        paintInterface()
    }
    
    override func loadView() {
        super.loadView()
        self.view = self.rootView
        rootView.controller = self
    }
    
    
    fileprivate func intialization(){
        loadProfileInfo()
    }
    
    fileprivate func paintInterface(){
        view.backgroundColor = .white
        paintLogout()
        paintNavigationTitle(text: "PROFILE")
    }
    
    //MARK:- Set rootView
    lazy var rootView : ProfileRootView = {
       let pv = ProfileRootView()
       
        return pv
    }()
    
    lazy var lbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "Under Development"
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: 18)
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    func loadProfileInfo(){
        guard let info = SignedUserInfo.sharedInstance else{
            return
        }
        rootView.loadProfileInfo(with: info)
    }
    
}
