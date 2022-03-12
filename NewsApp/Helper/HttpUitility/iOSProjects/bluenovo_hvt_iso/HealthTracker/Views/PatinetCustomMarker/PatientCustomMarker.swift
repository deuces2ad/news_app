//
//  PatientCustomMarker.swift
//  HealthTracker
//
//  Created by Apple on 04/10/21.
//

import Foundation

import GoogleMaps

class PatientCustomMarker : GMSMarker {
    

    
    lazy var customView : CustomMarkerView = {
        let marker = CustomMarkerView(frame: .zero, imageName: UIImage(), borderColor: AppThemeConfig.LightGreen, isWithDownArrow: true, isTagLblRequired: true)
        return marker
    }()

     init(with mainMap : GMSMapView) {
        super.init()
        self.map = mainMap
        self.iconView = customView

    }

}
