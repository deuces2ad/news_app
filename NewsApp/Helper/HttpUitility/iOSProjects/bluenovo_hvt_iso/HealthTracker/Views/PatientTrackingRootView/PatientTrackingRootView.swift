//
//  PatientTrackingRootView.swift
//  HealthTracker
//
//  Created by Grazitti on 24/09/21.
//

import Foundation
import UIKit
import GoogleMaps

class PatientTrackingRootView : ExtendedView{
    
    override func viewDidLayout() {
        super.viewDidLayout()
        intialization()
    }
    
    var controller : PatientTrackingController?
    
    
    func intialization(){
        setupViews()
        layoutUI()
    }
    
    
    lazy var mapView : GMSMapView =  {
        let map = GMSMapView()
        return map
    }()
    
    lazy var infoContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = AppThemeConfig.LightGreen
        view.layer.borderColor = AppThemeConfig.DarkGreen.cgColor
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.layer.borderWidth = 3
        return view
    }()
    
    lazy var arivingInfolbl : SideImageLabel = {
        let info = SideImageLabel(title: "Arriving in".localized() ?? "", image: UIImage(named: "ic_clock")!)
        return info
    }()
    
    lazy var distanceInfolbl : SideImageLabel = {
        let info = SideImageLabel(title: "Distance".localized() ?? "", image: UIImage(named: "ic_distance_doc")!)
        return info
    }()
    
    lazy var distanceLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: AppThemeConfig.defaultFont, size: 16)
        lbl.textColor = AppThemeConfig.DarkGreen
        lbl.numberOfLines = 0
        lbl.text = "01 Miles"
        return lbl
    }()
    
    lazy var arrvingLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: AppThemeConfig.defaultFont, size: 16)
        lbl.textColor = AppThemeConfig.DarkGreen
        lbl.numberOfLines = 0
        lbl.text = "02 Min"
        return lbl
    }()
    
    lazy var doctorMarker : CustomMarkerView = {
        let marker = CustomMarkerView(frame: .init(x: 0, y: 0, width: 60, height: 60), imageName:UIImage(named: "ic_doctor_car"), borderColor: .black, isWithDownArrow: false, isTagLblRequired: false)
        return marker
    }()
    
    
    lazy var customMarker : CustomMarkerView = {
        let marker = CustomMarkerView(frame: .init(x: 0, y: 0, width: 60, height: 60), imageName:#imageLiteral(resourceName: "ic_profile"), borderColor: .black, isWithDownArrow: true, isTagLblRequired: false)
        
        return marker
    }()
    
    func fillRouteInfo(with info : Leg?){
        guard let info = info else{return}
        self.distanceLbl.text = info.distance?.text
        self.arrvingLbl.text = info.duration?.text

    }
        
    func setupViews(){
        addSubview(mapView)
        addSubview(infoContainerView)
        infoContainerView.addSubview(arivingInfolbl)
        infoContainerView.addSubview(distanceInfolbl)
        infoContainerView.addSubview(distanceLbl)
        infoContainerView.addSubview(arrvingLbl)
    }
    
    func layoutUI(){
        _ = mapView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        _ = infoContainerView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 20, bottom: 20, right: 20),size: .init(width: 0, height: 0))
        
        _ = arivingInfolbl.anchor(top: infoContainerView.topAnchor, leading: infoContainerView.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 10, left: 20, bottom: 0, right: 0),size: .init(width: 100, height: 20))
        
        _ = distanceInfolbl.anchor(top: infoContainerView.topAnchor, leading: nil, bottom: nil, trailing: infoContainerView.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 20),size: .init(width: 100, height: 20))
        
        _ = distanceLbl.anchor(top: distanceInfolbl.bottomAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 10, left: 0, bottom: 0, right: 0))
          distanceLbl.centerX(inView: distanceInfolbl)

        _ = arrvingLbl.anchor(top: arivingInfolbl.bottomAnchor, leading: nil, bottom: infoContainerView.bottomAnchor, trailing: nil,padding: .init(top: 10, left: 0, bottom: 10, right: 0))
        arrvingLbl.centerX(inView: arivingInfolbl)
        
    }
    
    
    
    
}
