//
//  NewsFeedService.swift
//  NewsApp
//
//  Created by Apple on 12/03/22.
//

import Foundation


class NewsFeedService : NSObject{
    
   static func getNewsFeed(completionHandler: @escaping ((_ result : NewsFeedResponse?)->Void)){
        
        let urlString = "https://api.rss2json.com/v1/api.json?rss_url=http://www.abc.net.au/news/feed/51120/rss.xml"
        
        guard let requestUrl = URL(string: urlString) else {
            return
        }
        
        let huRequest = HURequest(withUrl: requestUrl, forHttpMethod: .get)
        
        HttpUtility.shared.request(huRequest: huRequest, resultType: NewsFeedResponse.self) { response in
            
            switch response {
            case .success(let newsFeed):
                print("succesfully fetched news feed")
                completionHandler(newsFeed)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
