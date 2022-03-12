//
//  WelcomeScreenRootView.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 29/07/21.
//

import Foundation
import UIKit


class WelcomeScreenRootView: ExtendedView {
    
    var controller : WelcomeScreenController?
    let TAG = "WelcomeScreenRootView"
    
    override func viewDidLayout() {
        super.viewDidLayout()
        initialization()
    }
    
    func initialization(){
        self.backgroundColor = UIColor(hexString: AppThemeConfig.idealGray)
        setupViews()
        setupContraonts()
    }
    
    let items  = ["SIGNIN","SIGNUP"]
    lazy var segmantalController : UISegmentedControl = {
        let sc = UISegmentedControl(items: items)
        sc.layer.cornerRadius = 9
        sc.layer.borderWidth = 1
        sc.layer.masksToBounds = true
        sc.backgroundColor = UIColor(hexString: AppThemeConfig.lightGreen)
        sc.tintColor = UIColor(hexString: AppThemeConfig.greenColor)
        sc.layer.borderColor = UIColor(hexString: AppThemeConfig.greenColor).cgColor
        sc.selectedSegmentTintColor = UIColor(hexString: AppThemeConfig.greenColor)
        sc.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white,
                                   NSAttributedString.Key.font : UIFont(name: AppThemeConfig.defaultFont, size: 16)!,
        ], for: .selected)
      
        sc.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white,
                                   NSAttributedString.Key.font : UIFont(name: AppThemeConfig.defaultFont, size: 16)!,
        ], for: .normal)
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(didtapOnSegmantController), for: .valueChanged)
        return sc
    }()
    
    @objc func didtapOnSegmantController(){
        Log.echo(key: TAG, text: "didtapOnSegmantController")
        self.controller?.resetTabs()
        
        if self.segmantalController.selectedSegmentIndex == 0{
            self.controller?.signinController?.view.isHidden = false
        }else{
            self.controller?.userTypeController?.view.isHidden = false
        }
    }

    
    func setupViews(){
        addSubview(segmantalController)
    }
    
    func setupContraonts(){
        _ = segmantalController.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 20, left: 20, bottom: 0, right: 20),size: .init(width: 0, height: 50))
    }
}
