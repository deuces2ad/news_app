//
//  DashBoardViewModal.swift
//  NewsApp
//
//  Created by Apple on 12/03/22.
//

import Foundation

class DashBoardViewModel : ObservableObject{
    
    @Published var newsFeeditems : [Item] = []
    
     // MARK: - News Service API
    func fetchNewsFeed(){
        
        NewsFeedService.getNewsFeed { result in
           
            guard let info = result else {
                return
            }
            print(info)
            DispatchQueue.main.async {
                self.newsFeeditems = info.items!
            }
            
        }
    }
    
}
