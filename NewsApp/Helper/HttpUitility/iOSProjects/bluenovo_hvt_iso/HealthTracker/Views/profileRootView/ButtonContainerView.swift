//
//  ButtonContainerView.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 31/07/21.
//

import Foundation
import UIKit

class ButtonContainerView: ExtendedView {
    

    //MARK: - Properties
    private lazy var headerLbl: UILabel = {
      let lbl = UILabel()
      lbl.textAlignment = .center
      lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .white
      lbl.font = UIFont(name: AppThemeConfig.defaultFont, size: 12)
      return lbl
    }()
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        setupView()
    }
    
    var btn : UIButton?
    
    init(button : UIButton,subHeading : String) {
        super.init(frame: .zero)
        self.headerLbl.text = subHeading
        self.btn = button
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView(){
        addSubview(btn ?? UIButton())
        addSubview(headerLbl)
        _ = btn?.anchor(top: topAnchor, leading: leadingAnchor, bottom: headerLbl.topAnchor, trailing: trailingAnchor,padding: .init(top: 5, left: 0, bottom: 0, right: 0))
       _ = headerLbl.anchor(top: nil, leading: leadingAnchor, bottom: self.bottomAnchor, trailing: trailingAnchor)
    }
}
