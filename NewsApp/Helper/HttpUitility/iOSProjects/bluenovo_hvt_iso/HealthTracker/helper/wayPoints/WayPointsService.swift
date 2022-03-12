//
//  WayPointsService.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 06/08/21.
//

import Foundation
import GoogleMaps


class  WayPointsService: NSObject {
    
    var mapPolyLine = GMSPolyline()
    var mapPath = GMSPath()
    
    func drawPathFrom( for locations: [CLLocationCoordinate2D],avoidTolls:Bool, completionHandler : @escaping (GMSPath?,GMSPolyline?)->Void){
        
//        let source = CLLocationCoordinate2D(latitude: 32.7266, longitude: 74.8570)
        
        guard let source =  LocationManager.shared.currentLocation?.location.coordinate else {
            return
        }
                
        let destination = locations.last!
        
        let originLoc = String(format: "%f,%f", source.latitude, source.longitude)
        let destinationLoc = String(format: "%f,%f", destination.latitude, destination.longitude)
        
        var wayPoints = ""
        for point in locations {
                        wayPoints = wayPoints.count == 0 ? "\(point.latitude),\(point.longitude)" : "\(wayPoints)|\(point.latitude),\(point.longitude)"
                    }
        
        let GOOGLE_DIRECTION_URL = "https://maps.googleapis.com/maps/api/directions/json"
        let utiltiy = HttpUtility.shared
        
        var addressRequest : DirectionRequest?
        
        if avoidTolls{
            addressRequest = DirectionRequest(origin: originLoc,destination: destinationLoc, key: AppConnectionConfig.GoogleMapKey, sensor: false, mode: .driving, waypoints: wayPoints,avoid: "tolls|highways")
        }else{
            addressRequest = DirectionRequest(origin: originLoc,destination: destinationLoc, key: AppConnectionConfig.GoogleMapKey, sensor: false, mode: .driving, waypoints: wayPoints)
        }

        
        
        
        
        guard let requestUrl = addressRequest.convertToQueryStringUrl(urlString: GOOGLE_DIRECTION_URL) else{
            return
        }
        Log.echo(key: "AbhiDirec", text: "\(requestUrl)")
        let request = HURequest(withUrl: requestUrl, forHttpMethod: .get)
        utiltiy.request(huRequest: request, resultType: DirectionResponse.self) { response in
           
            switch response{
            case .success(let direction):
                DispatchQueue.main.async {
                    if  direction?.status ==  "ZERO_RESULTS" {
                        Log.echo(key: "ERRORRRR", text: "NO ROUTESSSS")
                        RootControllerManager().getCurrentController()?.stopLoader()
                        RootControllerManager().getCurrentController()?.alert(withTitle: AppInfoConfig.appName, message: "Location is out of the continenet, please provie a valid location", successTitle: "Ok", rejectTitle: "cancel", showCancel: false, completion: nil)
                        return
                    }
                    
                    guard  let points = direction?.routes?[0].overviewPolyline?.points else  {
                        return
                    }
            
                    self.mapPath = GMSPath.init(fromEncodedPath: points) ?? GMSPath()
                    let polyline = GMSPolyline(path: self.mapPath)
                    polyline.strokeWidth = 3.0
                    polyline.strokeColor = AppThemeConfig.DarkGreen
                    self.mapPolyLine.map = nil
                    self.mapPolyLine = polyline
                    completionHandler(self.mapPath,self.mapPolyLine)
                }
 
            case .failure(let error):
                Log.echo(key: "GoogleAPIResponse", text: "\(error.localizedDescription)")
            }
        }
        
    }
    
  
}
