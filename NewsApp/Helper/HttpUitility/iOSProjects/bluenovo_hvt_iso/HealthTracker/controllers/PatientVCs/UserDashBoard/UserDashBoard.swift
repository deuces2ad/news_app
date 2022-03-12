//
//  UserDashBoard.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 12/08/21.
//

import Foundation
import UIKit

class UserDashBoardController: InterfaceExtendedController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intializeVariable()
    }
    
    func intializeVariable(){
        paintInterface()
        
    }
    
    func paintInterface() {
        paintNavigationTitle(text: "HOME".localized())
        view.backgroundColor = .white
        setupView()
    }
    
    lazy var lbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "Welcome to the C4YH application".localized()
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: 18)
        lbl.textAlignment = .center
        return lbl
    }()
    
   
    lazy var imgView : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Care4yourhealth")
        iv.contentMode = .scaleAspectFit

        return iv
    }()
    
   
    
    func setupView(){
        view.addSubview(lbl)
        view.addSubview(imgView)
        _ = lbl.anchor(top: nil, leading: self.view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        lbl.centerXY(inView: self.view)
        
        _ = imgView.anchor(top: nil, leading: nil, bottom: self.lbl.topAnchor, trailing: nil,padding: .init(top: 0, left: 0, bottom: -20, right: 0),size: .init(width: 300, height: 300))
        imgView.centerX(inView: lbl)
      
    }
    
    
}
