//
//  AboutUsController.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 29/07/21.
//

import Foundation
import UIKit

class AboutUsController: InterfaceExtendedController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        view.backgroundColor = .white
        paintLogout()
        paintNavigationTitle(text: "ABOUT US")
        paintHideBackButton()
        paintBackButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.title = "About Us"
    }
    
    lazy var lbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "Under Development"
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: 18)
        lbl.textAlignment = .center
        return lbl
    }()
    
   
    lazy var imgView : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "ic_development")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
   
    
    func setupView(){
        view.addSubview(lbl)
        view.addSubview(imgView)
        lbl.anchor(top: nil, leading: self.view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,size: .init(width: 100, height: 100))
        lbl.centerXY(inView: self.view)
        
        _ = imgView.anchor(top: nil, leading: nil, bottom: self.lbl.topAnchor, trailing: nil,padding: .init(top: 0, left: 0, bottom: -20, right: 0),size: .init(width: 50, height: 50))
        imgView.centerX(inView: lbl)
      
    }
    
    
}
