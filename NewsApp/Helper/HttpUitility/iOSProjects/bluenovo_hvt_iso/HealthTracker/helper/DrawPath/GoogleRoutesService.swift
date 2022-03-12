//
//  GoogleRoutesService.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 18/08/21.
//

import Foundation
import GoogleMaps


class GoogleRoutesService: NSObject {
    
    var mapPolyLine = GMSPolyline()
    var mapPath = GMSPath()
    var tripInfo : Leg? = Leg()
    
    
    func drawRouteBetween(from source: CLLocationCoordinate2D, destination : CLLocationCoordinate2D,withAnimatedPolyline : Bool, completionHandler : @escaping ((GMSPolyline?, GMSPath?, tripInfo : Leg?, [CLLocationCoordinate2D]?))->()){
        
        
        let GOOGLE_DIRECTION_URL = "https://maps.googleapis.com/maps/api/directions/json"
        let utiltiy = HttpUtility.shared
        
        let originLoc = String(format: "%f,%f", source.latitude, source.longitude)
        let destinationLoc = String(format: "%f,%f", destination.latitude, destination.longitude)
        
        let addressRequest = DirectionRequest(origin: originLoc, destination: destinationLoc, key: AppConnectionConfig.GoogleMapKey, sensor: false, mode: .driving)
        
        
        guard let requestUrl = addressRequest.convertToQueryStringUrl(urlString: GOOGLE_DIRECTION_URL) else{
            return
        }
        let request = HURequest(withUrl: requestUrl, forHttpMethod: .get)
        utiltiy.request(huRequest: request, resultType: DirectionResponse.self) { response in
           
            switch response{
            case .success(let direction):
                DispatchQueue.main.async {
                    if  direction?.status ==  "ZERO_RESULTS" {
                        Log.echo(key: "ERRORRRR", text: "NO ROUTESSSS")
                        
                        RootControllerManager().getCurrentController()?.alert(withTitle: AppInfoConfig.appName, message: "Location is out of the continenet, please provie a valid location", successTitle: "Ok", rejectTitle: "cancel", showCancel: false, completion: nil)
                        return
                    }
                    
                    
                    guard  let points = direction?.routes?[0].overviewPolyline?.points else  {
                        
                        return
                    }
                    
                    if let tripInfo = direction?.routes?[0].legs?[0]{
                        self.tripInfo = tripInfo
                    }
                    
                    self.mapPath = GMSPath.init(fromEncodedPath: points) ?? GMSPath()
                    let arrofLoc =  Polyline(encodedPolyline: points).coordinates
                    let polyline = GMSPolyline(path: self.mapPath)
                    polyline.strokeWidth = 5.0
                    self.mapPolyLine = polyline
                    completionHandler((self.mapPolyLine,self.mapPath,tripInfo:self.tripInfo, arrofLoc))
                }
 
            case .failure(let error):
                Log.echo(key: "GoogleAPIResponse", text: "\(error.localizedDescription)")
            }
        }
        
    }
    
  
}
