//
//  FutureAppointmentCell.swift
//  HealthTracker
//
//  Created by Apple on 22/11/21.
//

import Foundation
import UIKit

class FutureAppointmentCell : ExtendedTableCell{
    
    override func viewDidLayout() {
        super.viewDidLayout()
//        backgroundColor = .red
        intialization()
    }
    
    func intialization(){
        setupViews()
        layoutUI()
    }
    
    lazy var containerView : UIView = {
        let view = UIView()
        view.backgroundColor = AppThemeConfig.LightGreen
        view.rounded(cornerRadius: 6)
        return view
    }()
    
    lazy var appointmentLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "Header 1"
        return lbl
    }()
    
    
    func setupViews(){
        self.addSubview(containerView)
        self.containerView.addSubview(appointmentLbl)
    }
    
    func layoutUI(){
        _ = containerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        
        _ = appointmentLbl.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor)
        
    }
    
}


