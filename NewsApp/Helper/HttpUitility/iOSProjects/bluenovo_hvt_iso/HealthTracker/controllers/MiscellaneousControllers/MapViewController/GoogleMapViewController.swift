//
//  GoogleMapViewController.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 02/08/21.
//

import Foundation
import UIKit
import GoogleMaps
import MapKit
import CoreLocation


class GoogleMapViewController: InterfaceExtendedController {
    

    var didLoad:(()->())?
    var distance = 0.0
    var oldLocation : CLLocation?
    var driverMarker = GMSMarker ()
    var isNavigationStarted = false
    var doctorMovement = ARCarMovement()
    var totalTraveledDistance : Float = 0.0
    var startLocation : CLLocation?
    var currentLocation : CLLocation?{
        didSet{
            self.oldLocation = oldValue
        }
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLiveLocation()
        intializeVariable()
    }
    
    override func loadView() {
        super.loadView()
        view = self.rootView
    }
    fileprivate func intializeVariable(){
        rootView.controller = self
        movementOfDoctor()
    }
    
    
    lazy var rootView : GoogleMapRootView = {
        let rootview = GoogleMapRootView()
        return rootview
    }()
    
    
    func startNavigation(){
        LocationManager.shared.startUpdatingLocation {
            self.getLiveLocation()
        }
    }
    
    func getLiveLocation(){
        if let location = LocationManager.shared.currentLocation {
            self.currentLocation = location.location
            
            if isNavigationStarted{
                self.setLocation(location: location.location.coordinate)
                let request = LocationEmiterRequest(latitude: "\(location.location.coordinate.latitude)", longitude: "\(location.location.coordinate.longitude)", appointment_id: "4")
                EmitLiveLocation().shareLiveLocation(with: request) {
                    //
                }
                self.calculateDistance(isNavigationStarted: isNavigationStarted) {
                    calulateDistance(start: location.location, end: oldLocation!)
                }
            }
        }
    }
   
    
    func setLocation(location : CLLocationCoordinate2D){
        guard let oldLocation = oldLocation else{
            return
        }
        doctorMovement.arCarMovement(marker: driverMarker, oldCoordinate: oldLocation.coordinate, newCoordinate: location, mapView: rootView.mapView, bearing: 0.0)
        let camera = GMSCameraPosition(latitude: location.latitude, longitude: location.longitude,zoom: 15)
        CATransaction.begin()
        CATransaction.setValue(1.5, forKey: kCATransactionAnimationDuration)
        rootView.mapView.animate(to: camera)
        CATransaction.commit()
    }
    
    func movementOfDoctor(){
        let customMarker = CustomMarkerView(frame: .init(x: 0, y: 0, width: 60, height: 60), imageName:UIImage(named: "car"), borderColor: .black,isWithDownArrow: false, isTagLblRequired: false)
        driverMarker.iconView = customMarker
        driverMarker.icon = UIImage(named: "car")
        driverMarker.map = rootView.mapView
        if let liveLocation = currentLocation {
            doctorMovement.arCarMovement(marker: driverMarker, oldCoordinate: (liveLocation.coordinate), newCoordinate: (liveLocation.coordinate), mapView: rootView.mapView)
        }
        
    }
    
    func calculateDistance(isNavigationStarted : Bool,distance: ()->Double){
        if isNavigationStarted{
            let traveledDis = String(format: "%.2f", distance())
            Log.echo(key: "distance In Km", text: "\(traveledDis)")
            rootView.distanceLbl.text = "Total Traveled Distance(Miles) =\n\(traveledDis)"
        _ = distance()
        }else{
            Log.echo(key: "distance In Km", text: "Not started!1")
        }
    }
    
    func calulateDistance(start : CLLocation, end : CLLocation)-> Double{
       
        distance += start.distance(from: end)
//        Log.echo(key: "distanceAbhi", text: "\(distance)")
        let distanceInKM = distance * 0.000621371
        return Double(distanceInKM)
    }
    

   
}

