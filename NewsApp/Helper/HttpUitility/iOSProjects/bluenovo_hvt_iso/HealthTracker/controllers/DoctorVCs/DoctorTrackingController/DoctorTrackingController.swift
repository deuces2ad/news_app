//
//  DoctorTrackingController.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 18/08/21.
//

import Foundation
import UIKit
import CoreLocation
import GoogleMaps


class DoctorTrackingController: InterfaceExtendedController {
    
    
    let TAG = "DoctorTrackingController"
    var isTrackingStarted = false
    var appointmentId : Int?
    var patientName : String?
    var patientLoc : CLLocationCoordinate2D? = nil
    var doctorLoc : CLLocationCoordinate2D? = nil
    var oldLocation : CLLocation? = nil
    var liveLocation : CLLocation?{
        didSet{
            self.oldLocation = oldValue
        }
    }
    var doctorMovement = ARCarMovement()

    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        addObservers()
        initializeVariable()
        
    }
    
    //MARK: - LoadMapView
    init(with patinetLoc : CLLocationCoordinate2D) {
        super.init(nibName: nil, bundle: nil)
        self.patientLoc = patinetLoc
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        getLiveLocation()
        setupDoctoMarkerOnMap()
        drawPath()
        
    }
//
//    fileprivate  func addObservers() {
//          NotificationCenter.default.addObserver(self,
//                                                 selector: #selector(applicationDidBecomeActive),
//                                                 name: UIApplication.didBecomeActiveNotification,
//                                                 object: nil)
//        }
//
//    fileprivate  func removeObservers() {
//            NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
//        }

//    @objc fileprivate func applicationDidBecomeActive() {
//    // here do your work
//        self.setTabBarHidden(true)
//        }
//
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
//        removeObservers()
//        self.setTabBarHidden(false)
        self.tabBarController?.tabBar.isHidden = false
    }
//
    //MARK:- Initilization
    
    func initializeVariable(){
        rootView.controller = self
        rootView.patinetName.infoLbl.text = patientName
        paintInterface()
        
    }
    
    func paintInterface(){
        paintNavigationTitle(text: "Patient Route")
        paintBackButton()
    }
    

    //MARK:- rootView
    
    override func loadView() {
        super.loadView()
        view = rootView
        styleGoogleMaps(for: rootView.mapView)
    }
    
    lazy var rootView : DoctorTrackingRootView = {
        let rootView = DoctorTrackingRootView()
         UIWindow().addSubview(rootView)
        return rootView
    }()
    
    lazy var polyLineHelper : AGPolylinehelper = {
        let pl = AGPolylinehelper()
        pl.initializeWith(mapController: self, mapView: rootView.mapView, isAnimatedPolyline: true)
        return pl
    }()
    
    lazy var doctorMarker : GMSMarker = {
        let marker = GMSMarker()
        marker.iconView = rootView.customMarker
        marker.map = rootView.mapView
        return marker
    }()
    
    
    //MARK: -Draw Direction polyline
    func drawPath(){
        guard let doctorLoc = self.liveLocation?.coordinate, let patientLoc = patientLoc else{
            Log.echo(key: "ERROR!!!", text: "No location found")
            return
        }
        self.polyLineHelper.drawPolylineWith(pickUpLoc: doctorLoc, destinationLoc: patientLoc, isPolyLineAnimated: true) { [weak self] (response,tripInfo)  in
            guard let self = self else {return}
            self.boundMapView(with: doctorLoc, end: patientLoc, on: self.rootView.mapView)
            self.rootView.fillInfo(info: tripInfo)
        }
    }
    
    //MARK: - Open google maps..
    func openGoogleNavigationApp(withLocation  patientLoc : CLLocationCoordinate2D){
        guard let liveLocation = liveLocation else {
            return
        }

        let strLat = liveLocation.coordinate.latitude
        let strLong = liveLocation.coordinate.longitude
        
        let latDouble = patientLoc.latitude
        let lonDouble = patientLoc.longitude
        
        // dummy location
//        let latDouble = 32.2733
//        let lonDouble = 75.6522
        
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {  //if phone has an app
            
            self.rootView.stopNavigationBtn.setTitle(ButtonType.stopNavigation.rawValue.localized(), for: .normal)
            self.rootView.stopNavigationBtn.backgroundColor = .red
            self.rootView.controller?.isTrackingStarted = true
            self.rootView.controller?.startUpdatingLocations()
            
            if let url = URL(string: "comgooglemaps-x-callback://?saddr=\(strLat),\(strLong)&daddr=\(latDouble),\(lonDouble)&directionsmode=driving") {
                UIApplication.shared.open(url, options: [:])

            }} else {
            let appStoreUrl = "https://apps.apple.com/us/app/google-maps/id585027354"
            if let urlDestination = URL.init(string: appStoreUrl){
                UIApplication.shared.open(urlDestination)
            }
            
//            if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=\(strLat),\(strLong)&daddr=\(latDouble),\(lonDouble)&directionsmode=driving") {
//                UIApplication.shared.open(urlDestination)
//            }
                           
        }
    }
    
    //MARK: -Collect Live Location
    func getLiveLocation(){
        if let liveLocation = LocationManager.shared.currentLocation?.location {
            self.liveLocation = liveLocation
            doctorMarker.map = nil
            doctorMarker.position = liveLocation.coordinate
            Log.echo(key: TAG, text: "\(liveLocation.coordinate)")
            self.doctorLoc = liveLocation.coordinate
            // abhihekk : This is called if user enabled tracking and keeps on updating mapView camera
            if isTrackingStarted {
                setLocation(location: liveLocation.coordinate)
                let location = liveLocation.coordinate
                let request = LocationEmiterRequest(latitude: "\(location.latitude)", longitude: "\(location.longitude)", appointment_id: "\(appointmentId)")
                EmitLiveLocation().shareLiveLocation(with: request) { 
                    
                    //
                }
            }
        }
    }
    
    func startUpdatingLocations(){
        LocationManager.shared.startUpdatingLocation {
            self.getLiveLocation()
        }
    }
 
    
    func setupDoctoMarkerOnMap(){
        guard let doctorLoc = self.doctorLoc else {
            return
        }
        self.setMapViewCamera(location: doctorLoc, onMap: rootView.mapView, with: 17)
        doctorMarker.map = rootView.mapView
        doctorMovement.arCarMovement(marker: doctorMarker, oldCoordinate: doctorLoc, newCoordinate: doctorLoc, mapView: rootView.mapView)
    }
    
    func setLocation(location : CLLocationCoordinate2D){
        guard let oldLocation = oldLocation else{
            return
        }
        doctorMovement.arCarMovement(marker: doctorMarker, oldCoordinate: oldLocation.coordinate, newCoordinate: location, mapView: rootView.mapView, bearing: 0.0)
        
        self.setMapViewCamera(location: location, onMap: rootView.mapView, with: 17)
        
        self.polyLineHelper.drawPolylineWith(pickUpLoc: liveLocation!.coordinate, destinationLoc: patientLoc!, isPolyLineAnimated: false) { [weak self] (response,tripInfo)  in
            guard let self = self else {return}
            self.rootView.fillInfo(info: tripInfo)
            
            //emit live location here!
        }
    }
    
     // MARK: - Complete Appointment
//    func completeAppointment(){
//        let request  = EnrouteStatusRequest(appointment_id: self.appointment_id,status: .completed)
//        
//        EnrouteStatusService().updateInfo(for: request) { response in
//            
//            DispatchQueue.main.async {
//                self.stopLoader()
//                
//                if response?.success == true{
//                    self.navigationController?.popViewController(animated: true)
//                }else{
//                    RootControllerManager().getTopRootController()?.alert(withTitle: AppInfoConfig.appName, message: response?.message ?? "Error Occured", successTitle: "OK", rejectTitle: "", showCancel: false, completion: nil)
//                }
//                
//            }
//        }
//    }
 
  
    
}
