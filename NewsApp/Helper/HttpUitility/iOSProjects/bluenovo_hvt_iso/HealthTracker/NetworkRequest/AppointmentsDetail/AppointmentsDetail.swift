//
//  AppointmentsDetail.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 16/08/21.
//

import Foundation

class AppointmentsDetail: NSObject {
    
    let TAG = "AppointmentsDetail"
    
    func getInfo(with appointmentRequest : AppointmentRequest, completionHandler : @escaping (_ response : AppointmentDetailResponse?)->Void){
        
        let urlString = AppConnectionConfig.webServiceURL + "/appointmentDetail"
        
        guard let requestUrl = appointmentRequest.convertToQueryStringUrl(urlString: urlString) else {
            return
        }
        
        Log.echo(key: TAG, text: "request : \(requestUrl)")
        guard let token = SignedUserInfo.sharedInstance?.token else {
            Log.echo(key: TAG, text: "No token found!!!")
            return
        }
        let basicToken = "Bearer " + token
        Log.echo(key: TAG, text: " token is : \(token)")
        
        let urlRequest = HURequest(withUrl: requestUrl, forHttpMethod: .get)
        var uttility = HttpUtility.shared
        uttility.authenticationToken = basicToken
        
        uttility.request(huRequest: urlRequest, resultType: AppointmentDetailResponse.self) { response in
           
            switch response {
            case .success(let info):
                Log.echo(key: self.TAG, text: "Appointsments deatils fethched Successfully.......!!!!!! \(String(describing: info))")
                _ = completionHandler(info)
                
            case .failure(let error):
                Log.echo(key: self.TAG, text: "Error ocured!\(String(describing: error.serverResponse))")
                
            }
        }
    }
}
