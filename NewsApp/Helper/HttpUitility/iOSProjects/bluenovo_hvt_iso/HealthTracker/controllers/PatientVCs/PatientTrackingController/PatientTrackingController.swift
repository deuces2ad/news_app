//
//  PatientTrackingController.swift
//  HealthTracker
//
//  Created by Grazitti on 24/09/21.
//

import Foundation
import UIKit
import PusherSwift
import GoogleMaps

class PatientTrackingController : InterfaceExtendedController{
    
    
    var doctorMovement = ARCarMovement()
    var patientLocation : CLLocationCoordinate2D?
    var oldLocation : CLLocation?
    var currentLocation : CLLocation?{
        didSet{
            self.oldLocation = oldValue
        }
    }
    
    //MARK: - LifeCyle
    override func viewDidLoad() {
        super.viewDidLoad()
        intialization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func loadView() {
        super.loadView()
        view = rootView
        styleGoogleMaps(for: rootView.mapView)
        paintNavigationTitle(text: "Track".localized())
    }
    
    //MARK: - Intialization
    func intialization(){
        rootView.controller = self
        paintBackButton()
        registerForDoctotLiveLocation()
        
        self.patientMarker.position  =  patientLocation!
        
        //        drawPolyLineBetweennPatientAndStaff(with: CLLocationCoordinate2D(latitude: 39.03341075018869, longitude: -77.02358716747345))
        self.patientMarker.map = self.rootView.mapView
    }
    
    
    //MARK: - Set rootView
    lazy var rootView : PatientTrackingRootView = {
        let rootView = PatientTrackingRootView()
        return rootView
    }()
    
    lazy var doctorMarker : GMSMarker = {
        let marker = GMSMarker()
        marker.iconView = self.rootView.doctorMarker
        marker.map = rootView.mapView
        return marker
    }()
    
    lazy var patientMarker : GMSMarker = {
        let marker = GMSMarker()
        marker.iconView = self.rootView.customMarker
        marker.map = rootView.mapView
        return marker
    }()
    
    lazy var polyLineHelper : AGPolylinehelper = {
        let pl = AGPolylinehelper()
        pl.initializeWith(mapController: self, mapView: rootView.mapView, isAnimatedPolyline: true)
        return pl
    }()
    
    
    //MARK: - Register for LIVE Location Parameter
    func registerForDoctotLiveLocation(){
        guard let channel = UserSocket.sharedInstance?.pusherChannel else{
            Log.echo(key: "pusher@52", text: "no connection found")
            return
        }
        channel.bind(eventName: "testevent", eventCallback: { [self] (event: PusherEvent) in
            guard let json: String = event.data,
                  let jsonData: Data = json.data(using: .utf8)
            else {
                print("Could not convert JSON string to data")
                return
            }
            
            // decode the event data as json into a DebugConsoleMessage
            let decodedMessage = try? JSONDecoder().decode(PusherLocationResponse.self, from: jsonData)
            guard let message = decodedMessage else {
                print("Could not decode message")
                return
            }
            guard let lattitude = Double((message.location?.lat)!), let longitude = Double((message.location?.lng)!) else{
                return
            }
    
            self.currentLocation = CLLocation(latitude: lattitude, longitude: longitude)
            if oldLocation != nil {
                drawPolyLineBetweennPatientAndStaff(with: currentLocation!.coordinate)
            }else{
                drawPolyLineBetweennPatientAndStaff(with: currentLocation!.coordinate)
                self.doctorMarker.map = rootView.mapView
                self.doctorMarker.position = currentLocation!.coordinate
            }
            
        })
    }
    
    
    func moveDoctorCar(with location : CLLocationCoordinate2D, with marker : GMSMarker){
        guard let oldCoordinates = oldLocation?.coordinate else{
            return
        }
        doctorMovement.arCarMovement(marker: marker, oldCoordinate: (oldCoordinates), newCoordinate: (location), mapView: rootView.mapView)
    }
    
    //MARK: - Draw polyline
    
    func drawPolyLineBetweennPatientAndStaff(with doctorLocation : CLLocationCoordinate2D){

        guard let patinetLoc = self.patientLocation else {
            return
        }
        polyLineHelper.drawPolylineWith(pickUpLoc: doctorLocation, destinationLoc: patinetLoc, isPolyLineAnimated: true) {[weak self] response, tripInfo in
            guard let weakSelf = self else { return }
            weakSelf.rootView.fillRouteInfo(with: tripInfo)
            weakSelf.boundMapView(with: doctorLocation, end: patinetLoc, on: weakSelf.rootView.mapView)
            weakSelf.doctorMarker.map = weakSelf.rootView.mapView
            weakSelf.doctorMarker.position = doctorLocation
            CATransaction.begin()
            CATransaction.setValue(1.5, forKey: kCATransactionAnimationDuration)
            weakSelf.moveDoctorCar(with: doctorLocation, with: weakSelf.doctorMarker)
            CATransaction.commit()
        }
    }
    
}
