//
//  MapRootView.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 29/07/21.
//

import Foundation
import MapKit
import UIKit

class MapRootView: ExtendedView {
    
    
    var controller : MapViewController?
    
    override func viewDidLayout() {
        super.viewDidLayout()
        setupView()
    }
    
    
    lazy var mapView : MKMapView = {
        let map = MKMapView()
//        map.showsUserLocation = true
        return map
    }()
    
    func setupView(){
        addSubview(mapView)
        _ = self.mapView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
}
