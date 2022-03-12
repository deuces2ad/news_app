//
//  MapViewController.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 29/07/21.
//

import Foundation
import UIKit
import MapKit

class MapViewController: InterfaceExtendedController {
    
    var didLoad:(()->())?
    var currentLocation : CLLocation?
    
    let destinationCoordinates = CLLocationCoordinate2D(latitude: 19.136326, longitude: 72.827660)
    let thirdLocationCoordinates = CLLocationCoordinate2D(latitude: 19.0841, longitude: 72.8380)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intializeVariable()
        paintInterface()
    }
    
    override func loadView() {
        super.loadView()
        view = self.rootView
    }
    func paintInterface(){
        paintHideBackButton()
        paintLogout()
        paintNavigationTitle(text: "HOME")
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        LocationManager.shared.startUpdatingLocation  {
            self.showLocation()
        }
    }
    fileprivate func intializeVariable(){
       
       
        rootView.mapView.showsUserLocation = true
        self.rootView.mapView.delegate = self
    }
    
    
    func showLocation(){
        if let currentLocation =  LocationManager.shared.currentLocation{
            Log.echo(key: "LocationCoordinates", text: "\(currentLocation)")
            self.currentLocation = currentLocation.location
            showLocationOnMap()
        }
    }
    
    
    
    lazy var rootView : MapRootView = {
        let rootview = MapRootView()
        return rootview
    }()
    
    func showLocationOnMap(){
//            drawDirectionpath(with: self.currentLocation!.coordinate, destinationLocation: thirdLocationCoordinates)
        drawDirectionpath(with: self.currentLocation!.coordinate, destinationLocation: destinationCoordinates)
        drawDirectionpath(with: destinationCoordinates, destinationLocation: thirdLocationCoordinates)
        
    }
    
    func zoomAndCenter(on centerCoordinate: CLLocationCoordinate2D, zoom: Double) {
        var span: MKCoordinateSpan = rootView.mapView.region.span
        span.latitudeDelta *= zoom
        span.longitudeDelta *= zoom
        let region: MKCoordinateRegion = MKCoordinateRegion(center: centerCoordinate, span: span)
        rootView.mapView.setRegion(region, animated: true)
    }
    
    func drawDirectionpath(with currentLocation: CLLocationCoordinate2D, destinationLocation:CLLocationCoordinate2D){
        
        guard let currentCoordicates = self.currentLocation?.coordinate else {
            Log.echo(key: "abhi", text: "No current Location found")
            return
        }
        let sourceLocation = CLLocationCoordinate2D(latitude: currentCoordicates.latitude, longitude: currentLocation.longitude)
        let destinationLocation = destinationLocation
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlacemMark = MKPlacemark(coordinate: destinationLocation)
            
        
        let sourceItem = MKMapItem(placemark: sourcePlaceMark)
        let destinationItem = MKMapItem(placemark: destinationPlacemMark)
    
        
        let sourceAnotation = MKPointAnnotation()
        sourceAnotation.title = "Current Location"
        if let sourceLoc = sourcePlaceMark.location{
            sourceAnotation.coordinate = sourceLoc.coordinate
        }
        
        let destinationAnotation = MKPointAnnotation()
        sourceAnotation.title = "Destination Location"
        if let sourceLoc = destinationPlacemMark.location{
            sourceAnotation.coordinate = sourceLoc.coordinate
        }
        
        
        self.rootView.mapView.showAnnotations([sourceAnotation,destinationAnotation], animated: true)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceItem
        directionRequest.destination = destinationItem
        directionRequest.transportType = .automobile
        
        let direction = MKDirections(request: directionRequest)
        direction.calculate { response, error in
            guard let response = response else{
                if let error = error{
                    Log.echo(key: "locationError", text: error.localizedDescription)
                }
                return
            }
            let route = response.routes[0]
            self.rootView.mapView.addOverlay(route.polyline,level: MKOverlayLevel.aboveRoads)
         
            let rect = route.polyline.boundingMapRect
            let padding = UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100)
            self.rootView.mapView.setVisibleMapRect(rect,edgePadding: padding, animated: true)
        }
     
    }
    
}

extension MapViewController : MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let rander = MKPolylineRenderer(overlay: overlay)
        rander.lineWidth = 5
        rander.strokeColor = UIColor(hexString: AppThemeConfig.greenColor)
        return rander
    }
    
}
