//
//  DoctorTrackingRootView.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 18/08/21.
//

import Foundation
import GoogleMaps
import UIKit

class DoctorTrackingRootView: ExtendedView {
    
    
    weak var controller : DoctorTrackingController?
    var patientLocation : CLLocationCoordinate2D{
        return controller?.patientLoc ?? CLLocationCoordinate2D()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        setupView()
        layoutUI()
    }
    
    lazy var mapView : GMSMapView = {
        let map = GMSMapView()
        return map
    }()
    
    //MARK:- Properties
    lazy var navigationInfoWindow : UIView = {
        let view = UIView()
        view.backgroundColor = AppThemeConfig.LightGreen
        return view
    }()
    
    lazy var totalDistanceInfo : TrackingInfoView = {
        let td = TrackingInfoView(header: "Total Distance")
        td.backgroundColor = .white
        return td
    }()
    
    lazy var patinetName : TrackingInfoView = {
        let td = TrackingInfoView(header: "Patient's Name")
        td.backgroundColor = .white
        return td
    }()
    
    lazy var timeEstimateInfo : TrackingInfoView = {
        let td = TrackingInfoView(header: "Total Time")
        td.backgroundColor = .white
        return td
    }()
    
    lazy var trackingStackInfo : UIStackView = {
        let sv = UIStackView(arrangedSubviews: [totalDistanceInfo,patinetName,timeEstimateInfo])
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        return sv
    }()
    
    lazy var stopNavigationBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle(ButtonType.startNavigation.rawValue, for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = .systemGreen
        btn.addTarget(self, action: #selector(didTapStartNavigation), for: .touchUpInside)
        return btn
    }()
    
    lazy var customMarker : CustomMarkerView = {
        let marker = CustomMarkerView(frame: .init(x: 0, y: 0, width: 60, height: 60), imageName:UIImage(named: "car"), borderColor: .black, isWithDownArrow: false, isTagLblRequired: false)
        return marker
    }()
    
    func fillInfo(info : Leg?){
        guard let tripInfo = info else{
            return
        }
        DispatchQueue.main.async {
            let distaceInMiles = Int(Double((tripInfo.distance?.value)!) * 0.000621371)
            var distance = ""
            if distaceInMiles <= 1{
                distance = "0\(Int(distaceInMiles)) Mile"
            }else{
                distance = "\(Int(distaceInMiles)) Miles"
            }

            self.totalDistanceInfo.infoLbl.text = distance
            self.timeEstimateInfo.infoLbl.text =  tripInfo.duration?.text
        }
    }
    
    @objc func didTapStartNavigation(){
        if stopNavigationBtn.titleLabel?.text == ButtonType.stopNavigation.rawValue{
            
           
            self.controller?.navigationController?.popViewController(animated: true)
            
        }else{
            self.controller?.showLoader()
            let request  = EnrouteStatusRequest(appointment_id: self.controller?.appointmentId,status: .enroute)
            
            EnrouteStatusService().updateInfo(for: request) { reponse in
                DispatchQueue.main.async {
                    self.controller?.stopLoader()

                    guard let info = reponse else {
                        RootControllerManager().getTopRootController()?.alert(withTitle: AppInfoConfig.appName, message: "Coundn't decode backend message as admin has changed in modal class,Please connect with the admin team", successTitle: "OK", rejectTitle: "", showCancel: false, completion: nil)
                        return
                    }

                    if info.success == true{
                        self.controller?.openGoogleNavigationApp(withLocation: self.patientLocation)

                    }else{
                        RootControllerManager().getTopRootController()?.alert(withTitle: AppInfoConfig.appName, message: info.message ?? "ERORR OCCURED", successTitle: "OK", rejectTitle: "", showCancel: false, completion: nil)
                    }
                }
            }
            
//            DispatchQueue.main.async {
//                self.controller?.openGoogleNavigationApp(withLocation: self.patientLocation)
//            }
            
        }
        
    }
    
    
    
    //MARK: - SetupViews
    func setupView(){
        addSubview(navigationInfoWindow)
        addSubview(mapView)
        addSubview(trackingStackInfo)
        addSubview(stopNavigationBtn)
    }
    
    //MARK: - LayoutUI
    func layoutUI(){
        
        _ = navigationInfoWindow.anchor(top: nil, leading: leadingAnchor, bottom:bottomAnchor, trailing: trailingAnchor,size: .init(width: 0, height: 0))
        
        _ = self.mapView.anchor(top: topAnchor, leading: leadingAnchor, bottom: navigationInfoWindow.topAnchor, trailing: trailingAnchor)
        
        _ = trackingStackInfo.anchor(top: navigationInfoWindow.topAnchor, leading: navigationInfoWindow.leadingAnchor, bottom: nil, trailing: navigationInfoWindow.trailingAnchor,padding: .init(top: 5, left: 5, bottom: 0, right: 5),size: .init(width: 0, height: 50))
        
        _ = stopNavigationBtn.anchor(top: trackingStackInfo.bottomAnchor, leading: trackingStackInfo.leadingAnchor, bottom: navigationInfoWindow.bottomAnchor, trailing: trackingStackInfo.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 44, right: 0),size: .init(width: 0, height: 50))
        
    }
    
}

enum ButtonType : String {
    case  startNavigation = "START NAVIGATION"
    case  stopNavigation =  "STOP NAVIGATION"
}
