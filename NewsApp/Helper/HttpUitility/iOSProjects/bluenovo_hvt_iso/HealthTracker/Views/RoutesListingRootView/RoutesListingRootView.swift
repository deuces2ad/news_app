//
//  RoutesListingRootView.swift
//  HealthTracker
//
//  Created by Apple on 26/10/21.
//

import Foundation


import UIKit

class RoutesListingRootView : ExtendedView{
    
    var controller : RoutesListingController?
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        initalization()
    }
    
    
    func initalization(){
        setupViews()
        layoutUI()
    }
    
    lazy var appointmentsTblView : UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        return view
    }()
    
    
    func setupViews(){
        addSubview(appointmentsTblView)
    }
    
    func layoutUI(){
        _ = appointmentsTblView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
}
