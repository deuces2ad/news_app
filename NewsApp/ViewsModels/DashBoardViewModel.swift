//
//  DashBoardViewModal.swift
//  NewsApp
//
//  Created by Apple on 12/03/22.
//

import Foundation

class DashBoardViewModel : ObservableObject {
    
    @Published var newsFeedItems : [Item]? = []
    
    // MARK: - get news feed
    func fetchNewsFeed() {
        NewsFeedService.getNewsFeed { result in
            guard let newsFeed = result else { return }
           // DispatchQueue.main.async {
                self.newsFeedItems = newsFeed.items! //TODO: Avoid force unwrapping
            //}
        }
    }
}
