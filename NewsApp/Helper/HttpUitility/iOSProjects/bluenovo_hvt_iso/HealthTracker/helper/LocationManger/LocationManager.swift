//
//  LocationManager.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 29/07/21.
//

import Foundation
import UIKit
import CoreLocation
import MapKit


struct LocationAddress {
    var location : CLLocation
    
    init(location : CLLocation) {
        self.location = location
    }
}


typealias handler = () -> ()?
typealias totalDistanceHandler = () -> ()?

class LocationManager: NSObject {
    
   public static let shared = LocationManager()
    var locationUpdated : handler?
    var distanceTraveled : totalDistanceHandler?
    
    var currentLocation : LocationAddress?
    
    private var locationManger :CLLocationManager = {
        let locatioManager = CLLocationManager()
        locatioManager.desiredAccuracy =  kCLLocationAccuracyBestForNavigation
        locatioManager.distanceFilter = 10
        locatioManager.startUpdatingLocation()
        return locatioManager
    }()
 
    func
    startUpdatingLocation(completed : handler?){
        
        locationUpdated = completed
        locationManger.delegate = self
        locationManger.allowsBackgroundLocationUpdates = true
        locationManger.showsBackgroundLocationIndicator = true
        locationManger.requestWhenInUseAuthorization()
    }
    func stopUpdatingLocation(){
        locationManger.stopUpdatingLocation()
    }
}
  
extension LocationManager : CLLocationManagerDelegate{
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userlocation = locations.first else{
            return
        }
        
        if CLLocationCoordinate2DIsValid(userlocation.coordinate){
//            Log.echo(key: "abhishekD", text: userlocation.coordinate)
            currentLocation = .init(location: userlocation)
            if let update = locationUpdated{
                update()
            }

        }
       
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Log.echo(key: "abhishekD", text: error.localizedDescription)
    }
    
}

extension LocationManager {
    func resolveLocationName(with location : CLLocation,completion : @escaping((String?)->Void)){
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, preferredLocale: .current) { placemarks, error in
            guard let place = placemarks?.first, error == nil else {
                completion(nil)
                return
            }
            Log.echo(key: "resolveLocationName", text: "\(place)")
          
//            if let locality = place.locality{
//                name += locality
//            }
//
//            if let adminRegion = place.administrativeArea{
//                name += " ,\(adminRegion)"
//            }
            
            completion(place.compactAddress)
        }
    }
}
extension CLPlacemark {
var compactAddress: String? {
    if let name = name {
        var result = name
        
        if let region = region{
            result += ", \(region)"
        }

        if let administrativeArea = administrativeArea{
            result += ", \(administrativeArea)"
        }
        
        if let subAdministrativeArea = subAdministrativeArea{
            result += ", \(subAdministrativeArea)"
        }
        
        if let street = thoroughfare {
            result += ", \(street)"
        }
        if let city = locality {
            result += ", \(city)"
        }
        if let postalCode = postalCode {
            result += ", \(postalCode)"
        }
        if let country = country {
            result += ", \(country)"
        }
       
        
        return result
    }

    return nil
}
}

