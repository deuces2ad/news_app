//
//  GoogleMapRootView.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 02/08/21.
//

import Foundation
import UIKit
import GoogleMaps

class GoogleMapRootView: ExtendedView {
    
    
    var controller : GoogleMapViewController?
    
    override func viewDidLayout() {
        super.viewDidLayout()
        setupView()
    
    }
    
    
    lazy var mapView : GMSMapView = {
        let map = GMSMapView()
        return map
    }()
    
    
    lazy var startNavigationBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("START NAVIGATION".localized(), for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = AppThemeConfig.DarkGreen
        btn.addTarget(self, action: #selector(didTapTracking), for: .touchUpInside)
        return btn
        
    }()
    
    lazy var distanceLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: 18)
        lbl.textColor = .black
        lbl.backgroundColor = .white
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.text = "Total Traveled Distance (Miles)\n 0"
        return lbl
    }()
    
    @objc func didTapTracking(){
        controller?.distance = 0.0
        controller?.startNavigation()
        controller?.isNavigationStarted = true
       
    }
    func setupView(){
        addSubview(mapView)
        addSubview(startNavigationBtn)
        addSubview(distanceLbl)
        
        _ = self.mapView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        startNavigationBtn.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 20, bottom: 20, right: 20),size: .init(width: 0, height: 50))
        
        _ = distanceLbl.anchor(top: nil, leading: leadingAnchor, bottom: startNavigationBtn.topAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 20, bottom: 20, right: 20),size: .init(width: 0 , height: 50))
    
}
}
