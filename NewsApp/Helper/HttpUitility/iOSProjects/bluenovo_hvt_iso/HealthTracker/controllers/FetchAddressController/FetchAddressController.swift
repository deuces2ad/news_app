//
//  FetchAddressController.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 03/08/21.
//



import Foundation
import UIKit
import GoogleMaps

class FetchAddressController: InterfaceExtendedController {
    
    
    var geoCoder :CLGeocoder!
    var centerMapCoordinate:CLLocationCoordinate2D!
    var currentLocationCoordinates : CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
        arrangeCooridinates()
    }
    
    
    fileprivate func initialization(){
        paintInterface()
        rootView.mapView.delegate = self
        rootView.serchtxtFld.infoTxtField.delegate = self
        self.showLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
    }
    
    func showLocation(){
        if let currentLocation =  LocationManager.shared.currentLocation{
            Log.echo(key: "LocationCoordinates", text: "\(currentLocation)")
            let postion = GMSCameraPosition(latitude: currentLocation.location.coordinate.latitude, longitude: currentLocation.location.coordinate.longitude, zoom: 12)
            self.currentLocationCoordinates = currentLocation.location.coordinate
            rootView.mapView.animate(to: postion)
        }
    }
    fileprivate func paintInterface(){
        paintBackButton()
        paintNavigationTitle(text: "Address")
    }
    
    override func loadView() {
        super.loadView()
        view = rootView
        rootView.controller = self
        
    }
    
    lazy var rootView : FetchAdressRootView = {
        let rootview = FetchAdressRootView()
        return rootview
    }()
    
 
    
    func resolveLocationName(with coordinates : CLLocationCoordinate2D){
  
        let processor = GeoCodingProcessor()
        processor.reverseGeoCodeLocationWithInfo(coordinates) { result, response in
            
            let address = response?.results[0].formattedAddress
            Log.echo(key: "addres", text: "\(response?.results[0])")
            Log.echo(key: "location Is", text: "\(String(describing: address))")
            DispatchQueue.main.async {
                self.rootView.serchtxtFld.infoTxtField.text = address
                let newPosition = self.rootView.serchtxtFld.infoTxtField.beginningOfDocument
                self.rootView.serchtxtFld.infoTxtField.selectedTextRange = self.rootView.serchtxtFld.infoTxtField.textRange(from: newPosition, to: newPosition)
            }
        }
    }
    
    func arrangeCooridinates(){
        let pathankotLoc = CLLocationCoordinate2D(latitude: 32.2733, longitude: 75.6522)
        
        
        let nurpurLoc = CLLocationCoordinate2D(latitude: 32.3001, longitude: 75.8853)
        let chandigarhLoc = CLLocationCoordinate2D(latitude: 30.7333, longitude: 76.7794)
        let jammuLoc = CLLocationCoordinate2D(latitude: 32.7266, longitude: 74.8570)
        
        let locationsArr : [CLLocationCoordinate2D] = [pathankotLoc,jammuLoc,nurpurLoc,chandigarhLoc]
       let resolvedArr = self.getNearestPoints(array: locationsArr, currentLocation: pathankotLoc)
        Log.echo(key: "abhi", text: "sorted arry is\(resolvedArr)")
        
    }
    
    
    func animateCameraToCurrentLocation(){
        guard let currentLoc = self.currentLocationCoordinates else {
            return
        }
        let latlon = GMSCameraPosition(latitude: currentLoc.latitude, longitude: currentLoc.longitude, zoom: 12)
        self.rootView.mapView.animate(to: latlon)
    }
}

extension FetchAddressController : GMSMapViewDelegate{

    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        rootView.mapView.clear()
       
        let latitude = self.rootView.mapView.camera.target.latitude
        let longitude = self.rootView.mapView.camera.target.longitude
        centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        resolveLocationName(with: centerMapCoordinate)
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        if gesture{
            rootView.dragTheMapLbl.isHidden = true
        }
        
    }
    
}

extension FetchAddressController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
