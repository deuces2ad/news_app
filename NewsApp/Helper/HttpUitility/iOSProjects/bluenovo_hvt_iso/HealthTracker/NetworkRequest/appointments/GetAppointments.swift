//
//  GetAppointments.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 12/08/21.
//

import Foundation


class GetAppointments: NSObject {
    
    let TAG = "GetAppointments"
    
    func fetchInfo(completionHandler: @escaping (_ result: AppointmentsResponse?)->Void){
        
        let urlString = AppConnectionConfig.webServiceURL + "/appointments"
        
        guard let urlRequest = URL(string: urlString) else {
            Log.echo(key: TAG, text: "No URL found!!!")
            return
        }
        Log.echo(key: TAG, text: " URL is : \(urlRequest)")
        guard let token = SignedUserInfo.sharedInstance?.token else {
            Log.echo(key: TAG, text: "No token found!!!")
            return
        }
        Log.echo(key: TAG, text: " token is : \(token)")
        
        let request = HURequest(withUrl: urlRequest, forHttpMethod: .get)
    
        let basicToken = "Bearer " + token
        var utility = HttpUtility.shared
        utility.authenticationToken = basicToken
        
        
        utility.request(huRequest: request, resultType: AppointmentsResponse.self) { response in


            switch response {

            case .success(let appointmentsResponse ):

                guard let response =  appointmentsResponse else {
                    return
                }
                _ = completionHandler(response)
                Log.echo(key: self.TAG, text: "appointments Response is : ---\(response)")
            case .failure(let error):
                Log.echo(key: self.TAG, text: "Error ocured!\(String(describing: error.httpStatusCode))")
            }
        }
        
        
        
    }
}
