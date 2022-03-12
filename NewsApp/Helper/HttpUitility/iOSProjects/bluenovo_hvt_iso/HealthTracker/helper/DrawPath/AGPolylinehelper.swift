//
//  AGPolylinehelper.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 19/08/21.
//

import Foundation

import UIKit
import GoogleMaps


class AGPolylinehelper {
    
    private var polyLineInfo = GMSPolyline()
    private var animationPolyline = GMSPolyline()
    private var animationPath = GMSMutablePath()
    private var polyLinePath: GMSPath?
    private var i: UInt = 0
    private var timer: Timer?
    private var estimatedTimeHiddenMarker: GMSMarker?
    private var mapController : InterfaceExtendedController?
    private var isPolyLineAnimated : Bool?
    weak var animatePolyline : AnimatePolyline?
  
  
    
    private weak var mapView: GMSMapView?
   
    func initializeWith(mapController: InterfaceExtendedController?, mapView: GMSMapView?,isAnimatedPolyline : Bool) {
        self.mapView = mapView
        self.mapController = mapController
        self.isPolyLineAnimated = isAnimatedPolyline
    }
    
    func drawPolylineWith(pickUpLoc: CLLocationCoordinate2D, destinationLoc: CLLocationCoordinate2D,isPolyLineAnimated : Bool, completion: @escaping (_ finished: Bool, _ tripInfo :Leg?)->()){
        
        GoogleRoutesService().drawRouteBetween(from: pickUpLoc, destination: destinationLoc, withAnimatedPolyline: isPolyLineAnimated) { [weak self] (polyLineInfo,polyLinePath,tripInfo, arrofLoc) in
        
            UIView.animate(withDuration: 1.0) {
                if let allocatedSelf = self {
                    
                    allocatedSelf.removeAnimatedPolyline()
                   
                    allocatedSelf.animatePolyline?.stopAnimation()
                    guard let polyLines = polyLineInfo else {
                        return
                    }
                    allocatedSelf.polyLineInfo.map = nil
                    polyLines.strokeColor = AppThemeConfig.DarkGreen
                    allocatedSelf.polyLineInfo = polyLines
                    allocatedSelf.polyLinePath = polyLinePath
                    allocatedSelf.polyLineInfo.map = allocatedSelf.mapView

                }
                completion(true, tripInfo)
            }
           
        }
    }
    
    func removeAnimatedPolyline() {
      self.animationPolyline.map = nil
      self.timer?.invalidate()
    }
    
    
    @objc private func animatePolylinePath() {
        if (self.i < (self.polyLinePath?.count())!) {
            UIView.animate(withDuration: 0.009, delay: 0, options: .curveEaseOut, animations: {
                self.animationPath.add((self.polyLinePath?.coordinate(at: self.i))!)
                self.animationPolyline.path = self.animationPath
                self.animationPolyline.strokeColor = AppThemeConfig.LightGreen
                self.animationPolyline.strokeWidth = 3
                self.animationPolyline.map = self.mapView
                self.i += 1
            }, completion: nil)
        }
        else {
            self.i = 0
            self.animationPath = GMSMutablePath()
            self.animationPolyline.map = nil
        }
    }
}
