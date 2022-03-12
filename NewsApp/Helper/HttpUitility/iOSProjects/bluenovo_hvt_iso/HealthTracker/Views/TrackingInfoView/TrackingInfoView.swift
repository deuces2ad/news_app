//
//  TrackingInfoView.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 20/08/21.
//

import Foundation
import UIKit

class TrackingInfoView: ExtendedView {
    
    override func viewDidLayout() {
        super.viewDidLayout()
        setupViews()
        layoutUI()
    }
    
    lazy var headerlbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: AppThemeConfig.defaultFont, size: 14)
        lbl.textColor = .lightGray
        lbl.textAlignment = .center
        return lbl
    }()
    
    lazy var infoLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: 14)
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    
    init(header : String) {
        super.init(frame: .zero)
        self.headerlbl.text = header
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- SetupView
    func setupViews(){
       addSubview(headerlbl)
        addSubview(infoLbl)
    }
    
    //MARK:- Layout UI
    
    func layoutUI(){
        _ = headerlbl.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        _  = infoLbl.anchor(top: headerlbl.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    
}
