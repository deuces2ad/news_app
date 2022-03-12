//
//  GeoCodingProcessor.swift
//  GenGold
//
//  Created by Sumant Handa on 05/08/16.
//  Copyright © 2016 Mansa. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

@objc class GeoCodingProcessor : NSObject{
    
    let GOOGLE_GEO_CODING_URL = "https://maps.googleapis.com/maps/api/geocode/json"
    
    func forwardGeoCodeLocation(_ address : String, completion : @escaping ((_ success : Bool, _ location : CLLocationCoordinate2D?, _ info : GeoCodeInfo?)->())){
//        forwardGoogleGeoCodeLocation(address, completion: completion)
        return
    }
    
     func reverseGeoCodeLocationInfo(withLocation locationInfo : CLLocationCoordinate2D, completion : @escaping ((_ success : Bool, _ info : GeoCodeInfo?)->())){
        reverseGoogleGeoCodeLocation(locationInfo, completion: completion)
        return
    }
    
     func reverseGeoCodeLocation(_ locationInfo : CLLocationCoordinate2D, completion : @escaping ((_ success : Bool, _ text : String?)->())){
//        reverseGoogleGeoCodeLocation(locationInfo) { (success, info) in
//            completion(success, info?.address)
//        }
        return
    }
    
     func reverseGeoCodeLocationWithInfo(_ locationInfo : CLLocationCoordinate2D, completion : @escaping ((_ success : Bool, _ Info : GeoCodeInfo?)->())){
        reverseGoogleGeoCodeLocation(locationInfo) { (success, info) in
            completion(success, info)
        }
        return
    }
}


extension GeoCodingProcessor{
    
//    func forwardGoogleGeoCodeLocation(_ address : String, completion : @escaping ((_ success : Bool, _ location : CLLocationCoordinate2D? , _ info : GeoCodeInfo?)->())){
//        let processor = ServerProcessor()
//        let params = ["address" : address, "key" : "AIzaSyDp-LHVdb55B_stVrFIO3N77DvpKr_kV0M"]
//
//        processor.request(.get, GOOGLE_GEO_CODING_URL, parameters: params as [String : AnyObject]?, completion: { (success, response) in
//            //Log.echo(key: "MAP param", text: "success => \(success)")
//            //Log.echo(key: "MAP param", text: "response => \(response)")
//
//            // MARK:- TO-DO update the completion for get geocoding info ***///
//            self.parseForwardLocation(success, response: response, completion: { (success, location, info) in
//                completion(success, location, info)
//                return
//            })
//        })
//    }
    
    //*** MARK:- TO-DO add geocoding info for save the location **//
//    fileprivate func parseForwardLocation(_ success : Bool, response : JSON?, completion : ((_ success : Bool, _ location : CLLocationCoordinate2D?, _ info : GeoCodeInfo?)->()) ){
//        if(!success){
//            completion(false, nil, nil)
//            return
//        }
//
//        guard let json = response
//            else{
//                completion(false, nil, nil)
//                return
//        }
//
//        let infosData = json["results"].array ?? []
//        if(infosData.count == 0){
//            completion(false, nil, nil)
//            return
//        }
//
//        guard let locationInfoData = infosData[0]["geometry"]["location"].dictionary
//            else{
//                completion(false, nil, nil)
//                return
//        }
//
//        let latitude = locationInfoData["lat"]?.double ?? 0.00
//        let longitude = locationInfoData["lng"]?.double ?? 0.00
//
//        let locationInfo = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//        let info = GeoCodeInfo(info: json)
//        completion(true, locationInfo, info)
//        return
//
//    }
    
}
extension GeoCodingProcessor{
    
    func reverseGoogleGeoCodeLocation(_ locationInfo : CLLocationCoordinate2D, completion : @escaping ((_ success : Bool, _ info : GeoCodeInfo?)->())){
        
        let utiltiy = HttpUtility.shared
        let locationString = String(format: "%f,%f", locationInfo.latitude, locationInfo.longitude)
        Log.echo(key: "requestt", text: locationString)

        let addressRequest = GeoCodingRequest(latlng: locationString, key: AppConnectionConfig.GoogleMapKey)
        guard let requestUrl = addressRequest.convertToQueryStringUrl(urlString: GOOGLE_GEO_CODING_URL) else{
            return
        }
        let request = HURequest(withUrl: requestUrl, forHttpMethod: .get)
        utiltiy.request(huRequest: request, resultType: GeoCodeInfo.self) { response in
            
            switch response{
            case .success(let response):
                completion(true, response)
                
            case .failure(let error):
                Log.echo(key: "GeoCode", text: "\(error)")
            }
        }
        
    }

}
